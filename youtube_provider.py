"""
Usage
-----

0. 安装最新版 [youtube-dl](https://github.com/ytdl-org/youtube-dl)
1. 下载上述脚本
2. 修改第 20 行，将 proxy 地址改成一个自己的（否则可能有未知问题）
3. 执行 `fuo exec < youtube_provider.py`

播放周杰伦的叶惠美专辑，执行
```
fuo exec "play_youtube('https://music.youtube.com/playlist?list=OLAK5uy_luGzxd76PlO-rZN-Nh_MRoD81ukS_D7os')"
```

播放 no matter what
```
fuo exec "play_youtube('https://www.youtube.com/watch?v=7eul_Vt6SZY')"
```

Best Pratice
------------

在 `~/.fuorc` 中进行配置，代码如下（请自己修改目录）
```
import os
when('app.initialized',
     lambda *args: source(os.path.expanduser('~/coding/rcfiles/youtube_provider.py')))
```

自己在 PATH 下新建一个脚本，比如 `youtube-dl-fuo`
```
#!/bin/bash

fuo exec "play_youtube('$1')"
```
"""


import os
import sys
import logging
import json
import random
import subprocess

from fuocore.excs import ProviderIOError
from fuocore.provider import AbstractProvider
from fuocore.models import SongModel, cached_field, SearchModel, \
    SearchType, ModelStage, VideoModel
from fuocore.media import Media

logger = logging.getLogger('feeluown')


no_proxy_list = [
    '.126.net',
    '.qq.com',
    '.bilibili.com',
    '.bilivideo.com',
    '.hdslb.com',  # bilibili video cover
    '.acgvideo.com',
    '.xiami.com',
    '.163.com',
    '.xiami.net',
    '.gtimg.cn',  # qqmusic image
    '.kuwo.cn',
    '.cn',
]

# os.environ['http_proxy'] = 'http://127.0.0.1:1087'
# os.environ['https_proxy'] = 'http://127.0.0.1:1087'
os.environ['no_proxy'] = ','.join(no_proxy_list)


APP = app  # noqa


class YoutubeDlError(ProviderIOError):
    pass


def run_youtube_dl(*args, timeout=2, **kwargs):
    if sys.version_info >= (3, 7):
        kwargs.setdefault('capture_output', True)
    else:
        kwargs.setdefault('stdout', subprocess.PIPE)
    cmd = ['youtube-dl', '--socket-timeout', str(timeout)]
    cmd.extend(args)
    logger.info('run cmd: %s', ' '.join(cmd))
    p = subprocess.run(cmd, **kwargs)
    if p.returncode == 0:
        return p
    raise YoutubeDlError(p.stderr.decode())


class YoutubeProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'youtube'

    @property
    def name(self):
        return 'YouTube'

    def search(self, keyword, type_, *args, **kwargs):
        if SearchType(type_) != SearchType.vi:
            return None
        limit = kwargs.get('limit', 10)
        p = run_youtube_dl('--flat-playlist', '-j', f"ytsearch{limit}: {keyword}")
        if p.returncode == 0:
            stdout = p.stdout
            models = []
            for line in stdout.decode().splitlines():
                data = json.loads(line)
                model = YoutubeModel.from_youtubedl_output(data)
                models.append(model)
            return SearchModel(videos=models)


class BilibiliProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'bilibili'

    @property
    def name(self):
        return 'bilibili'


youtube_provider = YoutubeProvider()
bilibili_provider = BilibiliProvider()


class BilibiliModel(VideoModel):
    source = bilibili_provider.identifier

    class Meta:
        provider = bilibili_provider
        fields_no_get = ['url']
        allow_get = True

    @classmethod
    def get(cls, identifier):
        identifier = str(identifier)
        if identifier.isdigit():
            yurl = 'https://www.bilibili.com/video/av' + identifier
        else:
            yurl = 'https://www.bilibili.com/video/BV' + identifier
        p = run_youtube_dl('--flat-playlist', '-j', yurl)
        if p.returncode == 0:
            text = p.stdout.decode()
            data = json.loads(text)
            song = cls.from_youtubedl_output(data)
            return song
        return None

    @classmethod
    def from_youtubedl_output(cls, data):
        url = data['url']
        media = Media(url,
                      http_headers={'Referer': 'https://www.bilibili.com/'})
        return cls(identifier=data['id'],
                   duration=data['duration'],
                   cover=data['thumbnail'],
                   description=data['description'],
                   media=media,
                   title=data['title'],
                   stage=ModelStage.gotten)

    @cached_field(ttl=3600)
    def url(self):
        model = BilibiliModel.get(self.identifier)
        url = self.url = model.url
        return url


class YoutubeModel(VideoModel):
    source = youtube_provider.identifier

    class Meta:
        provider = youtube_provider
        allow_get = True

    @classmethod
    def get(cls, identifier):
        vurl = f"https://youtube.com/watch?v={identifier}"
        p = run_youtube_dl('--flat-playlist', '-j', vurl)
        if p.returncode == 0:
            text = p.stdout.decode()
            data = json.loads(text)
            formats = data['formats']
            valid_formats = []
            for format in formats:
                if format['acodec'] != 'none' and format['vcodec'] != 'none':
                    valid_formats.append(format)
            valid_formats = valid_formats if valid_formats else formats
            media = random.choice(valid_formats)['url']
            print(f'youtube:{identifier}:{media}')
            print(f"thumbnail:{data['thumbnail']}")
            model = cls(cover=data['thumbnail'],
                        title=data['title'],
                        media=media,
                        stage=ModelStage.gotten)
            return model
        return None

    @classmethod
    def from_youtubedl_output(cls, meta):
        if '_type' in meta:
            if meta['_type'] != 'url':
                return None
            identifier = meta['url']
            title = meta.get('title', 'unknown')
        else:
            # TODO: we can extract complete song info here
            identifier = meta['id']
            title = meta['title']
        return cls.create_by_display(identifier=identifier,
                                     title=title,)

    @cached_field(ttl=3600*5)
    def media(self):
        video = self.get(self.identifier)
        return video.media

    def old_get_media(self):
        vurl = "https://youtube.com/watch?v=" + self.identifier
        p = run_youtube_dl('-g', '--youtube-skip-dash-manifest', vurl)
        if p.returncode == 0:
            content = p.stdout.decode()
            logger.info(content)
            video = audio = ''
            for line in content.splitlines():
                if 'mime=video' in line:
                    video = line
                if 'mime=audio' in line:
                    audio = line
            url = video
            if url:
                self.media = url
                return url
            logger.warn('no valid media')
        logger.error(p.stderr.decode())
        return None


def _generate_models(url):
    p = run_youtube_dl('-j', '--flat-playlist', url, timeout=2)
    models = []
    if p.returncode == 0:
        stdout = p.stdout
        for line in stdout.decode().splitlines():
            meta = json.loads(line)
            if 'extractor_key' in meta:
                source = meta['extractor_key'].lower()
            elif 'ie_key' in meta:
                source = meta['ie_key'].lower()
            else:
                raise Exception('this is a bug')
            if source == bilibili_provider.identifier:
                model_cls = BilibiliModel
            elif source == youtube_provider.identifier:
                model_cls = YoutubeModel
            else:
                model_cls = None
            if model_cls is not None:
                model = model_cls.from_youtubedl_output(meta)
                if model is not None:
                    models.append(model)
    return models


def _play_models(models):
    for model in models:
        print('add-to-playlist: {}'.format(model))
        APP.playlist.add(model)
    APP.player.play_song(models[0])


def play_youtube(url):
    models = _generate_models(url)
    if models:
        print('found {} song'.format(len(models)))
        _play_models(models)
    else:
        print('no available song found')


# re-register provider
for identifier in ('bilibili', 'youtube'):
    provider = APP.library.get(identifier)
    if provider is not None:
        APP.library.deregister(provider)

APP.library.register(youtube_provider)
APP.library.register(bilibili_provider)


# play_youtube('https://music.youtube.com/playlist?list=OLAK5uy_luGzxd76PlO-rZN-Nh_MRoD81ukS_D7os')
