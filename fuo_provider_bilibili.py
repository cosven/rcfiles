import asyncio

from bilibili_api import video

from feeluown.library import (
    ProviderV2, ProviderFlags as PF, AbstractProvider,
    ModelType, VideoModel, BriefArtistModel,
)
from feeluown.media import Quality, Media, MediaType


def sync(coro):
    # FIXME: Use async_to_sync in asgiref
    return asyncio.run(coro)


def create_video(identifier):
    if identifier.isdigit():
        v = video.Video(aid=int(identifier))
    else:
        v = video.Video(bvid=identifier)
    return v


class BilibiliProvider(AbstractProvider, ProviderV2):
    class meta:
        identifier = 'bilibili'
        name = 'Bilibili'
        flags = {
            ModelType.video: (PF.get | PF.multi_quality | PF.model_v2),
        }

    @property
    def identifier(self):
        return self.meta.identifier

    @property
    def name(self):
        return self.meta.name

    def video_get(self, vid: str):
        v = create_video(vid)
        info = sync(v.get_info())
        artists=[BriefArtistModel(source=self.meta.identifier,
                                  identifier=info['owner']['mid'],
                                  name=info['owner']['name'])]
        video = VideoModel(source=self.meta.identifier,
                           identifier=vid,
                           title=info['title'],
                           artists=artists,
                           duration=info['duration'],
                           cover=info['pic'])
        # `pages` means how much parts a video have.
        # TODO: each part should be a video model and have its own identifier
        video.cache_set('pages', [{'cid': page['cid']} for page in info['pages']])
        return video

    def video_get_media(self, video, quality):
        q_media_mapping = self._get_or_fetch_q_media_mapping(video)
        return q_media_mapping.get(quality)

    def video_list_quality(self, video):
        q_media_mapping = self._get_or_fetch_q_media_mapping(video)
        return list(q_media_mapping.keys())

    def _get_or_fetch_q_media_mapping(self, video):
        v = create_video(video.identifier)
        pages = self._model_cache_get_or_fetch(video, 'pages')
        assert pages, 'this should not happend, a video has no part'
        url_info = sync(v.get_download_url(cid=pages[0]['cid']))
        q_media_mapping = self._parse_media_info(url_info)
        video.cache_set('q_media_mapping', q_media_mapping)
        return q_media_mapping

    def _parse_media_info(self, url_info):
        q_media_mapping = {}
        dash_info = url_info['dash']
        for q in sorted(url_info['accept_quality'], reverse=True)[:4]:
            for video in dash_info['video']:
                if video['id'] == q:
                    media = Media(video['base_url'],
                                  type_=MediaType.video,
                                  http_headers={'Referer': 'https://www.bilibili.com/'})
                    # TODO: handle more qualities
                    if q >= 32:
                        q_media_mapping[Quality.Video.hd] = media
                    else:
                        q_media_mapping[Quality.Video.sd] = media
        return q_media_mapping

APP = app
provider = BilibiliProvider()
tmp_provider = APP.library.get(provider.meta.identifier)
if tmp_provider is not None:
    APP.library.deregister(tmp_provider)
APP.library.register(provider)
