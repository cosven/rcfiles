import os
import time
import json
import subprocess

from fuocore.provider import AbstractProvider
from fuocore.models import SongModel
from fuocore.media import Media


no_proxy_list = [
    '.126.net',
    '.qq.com',
    '.bilibili.com',
    '.acgvideo.com',
    '.xiami.com',
    '.163.com',
    '.xiami.net',
]

os.environ['http_proxy'] = 'http://127.0.0.1:1087'
os.environ['no_proxy'] = ','.join(no_proxy_list)


APP = app  # noqa


class YoutubeProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'youtube'

    @property
    def name(self):
        return 'YouTube'


class BilibiliProvider(AbstractProvider):
    @property
    def identifier(self):
        return 'bilibili'

    @property
    def name(self):
        return 'bilibili'


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

    @property
    def url(self):
        if hasattr(self, '_url'):
            if self._expire_at >= time.time():
                url = self._url
            else:
                song = BilibiliModel.get(self.identifier)
                url = self.url = song.url
            return url
        return None

    @url.setter
    def url(self, url):
        self._url = url
        # from old experience, will be expired after 5 hour
        self._expire_at = time.time() + 3600 * 1


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
            title = meta['title']
        else:
            # TODO: we can extract complete song info here
            identifier = meta['id']
            title = meta['title']
        return cls(identifier=identifier,
                   title=title,)

    @property
    def url(self):
        if hasattr(self, '_url') and self._expire_at < time.time():
            return self._url
        vurl = "https://youtube.com/v/" + self.identifier
        p = subprocess.run(['youtube-dl', '-g', vurl],
                           capture_output=True)
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
        return ''

    @url.setter
    def url(self, url):
        self._url = url
        # from old experience, will be expired after 5 hour
        self._expire_at = time.time() + 3600 * 5

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
            source = meta['extractor_key'].lower()
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
