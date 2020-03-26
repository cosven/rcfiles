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
import time
import json
import subprocess

from fuocore.provider import AbstractProvider
from fuocore.models import SongModel, cached_field, SearchModel
from fuocore.media import Media


no_proxy_list = [
    '.126.net',
    '.qq.com',
    '.bilibili.com',
    '.bilivideo.com',
    '.acgvideo.com',
    '.xiami.com',
    '.163.com',
    '.xiami.net',
    '.gtimg.cn',  # qqmusic image
]

# os.environ['http_proxy'] = 'http://127.0.0.1:1087'
os.environ['no_proxy'] = ','.join(no_proxy_list)


APP = app  # noqa


class YoutubeProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'youtube'

    @property
    def name(self):
        return 'YouTube'

    def search(self, keyword, *args, **kwargs):
        limit = kwargs.get('limit', 10)
        p = subprocess.run(
            ['youtube-dl', '--flat-playlist', '-j', f"ytsearch{limit}: {keyword}"],
            capture_output=True
        )
        if p.returncode == 0:
            stdout = p.stdout
            songs = []
            for line in stdout.decode().splitlines():
                data = json.loads(line)
                song = YoutubeModel.from_youtubedl_output(data)
                songs.append(song)
            return SearchModel(songs=songs)


class BilibiliProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'bilibili'

    @property
    def name(self):
        return 'bilibili'


# re-register provider
for identifier in ('bilibili', 'youtube'):
    provider = APP.library.get(identifier)
    if provider is not None:
        APP.library.deregister(provider)

youtube_provider = YoutubeProvider()
bilibili_provider = BilibiliProvider()
APP.library.register(youtube_provider)
APP.library.register(bilibili_provider)


class BilibiliModel(SongModel):
    source = bilibili_provider.identifier

    class Meta:
        provider = bilibili_provider
        fields_no_get = ['url']

    @classmethod
    def get(cls, identifier):
        yurl = 'https://www.bilibili.com/video/av' + str(identifier)
        p = subprocess.run(['youtube-dl', '--flat-playlist', '-j', yurl],
                           capture_output=True)
        if p.returncode == 0:
            text = p.stdout.decode()
            data = json.loads(text)
            song = cls.from_youtubedl_output(data)
            return song
        return None

    @classmethod
    def from_youtubedl_output(cls, data):
        duration = data['duration']
        url = data['url']
        media = Media(url,
                      http_headers={'Referer': 'https://www.bilibili.com/'})
        title = data['title']
        return cls(identifier=data['id'],
                   duration=duration,
                   url=media,
                   title=title)

    @cached_field(ttl=3600)
    def url(self):
        song = BilibiliModel.get(self.identifier)
        url = self.url = song.url
        return url


class YoutubeModel(SongModel):
    source = youtube_provider.identifier

    class Meta:
        provider = youtube_provider
        allow_get = False

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
        return cls(identifier=identifier,
                   title=title,)

    @cached_field(ttl=3600*5)
    def url(self):
        vurl = "https://youtube.com/watch?v=" + self.identifier
        cmd = ['youtube-dl', '-g', '--youtube-skip-dash-manifest', vurl]
        p = subprocess.run(cmd, capture_output=True)
        if p.returncode == 0:
            video = audio = ''
            for line in p.stdout.decode().splitlines():
                if 'mime=video' in line:
                    video = line
                if 'mime=audio' in line:
                    audio = line
            url = audio
            if url:
                self.url = url
                return url
        return None

    @property
    def duration_ms(self):
        """hack: there is a bug in SongModel.duration_ms implementation"""
        return '00:00'


def _generate_models(url):
    p = subprocess.run(['youtube-dl', '-j', '--flat-playlist', url],
                       capture_output=True)
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


# play_youtube('https://music.youtube.com/playlist?list=OLAK5uy_luGzxd76PlO-rZN-Nh_MRoD81ukS_D7os')
