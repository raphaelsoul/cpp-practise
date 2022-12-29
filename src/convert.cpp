#include <cstdio>

#ifdef __cplusplus
extern "C" {
#endif

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

#ifdef __cplusplus
}
#endif

void SaveFrame() {
  AVFormatContext* ctx = avformat_alloc_context();

  const char* file_path =
      "/Users/kagari/projects/github.com/streaming/big_buck_bunny.mp4";
  int ret = avformat_open_input(&ctx, file_path, NULL, NULL);

  if (ret < 0) {
    printf("fail open video file\n");
    return;
  }

  ret = avformat_find_stream_info(ctx, NULL);

  if (ret < 0) {
    printf("fail collect file info");
    return;
  }

  int video_index = -1;
  int audio_index = -1;

  video_index = av_find_best_stream(ctx, AVMEDIA_TYPE_VIDEO, -1, -1, NULL, 0);
  audio_index = av_find_best_stream(ctx, AVMEDIA_TYPE_AUDIO, -1, -1, NULL, 0);

  printf("video_index = %d \n", video_index);
  printf("audio_index = %d \n", audio_index);

  printf("media name = %s\n", ctx->url);
  printf("stream number = %d\n", ctx->nb_streams);
  printf("media avg ratio = %lld / kbps\n", ctx->bit_rate / 1024);

  int const hours = ctx->duration / AV_TIME_BASE / 3600;
  int const minutes = ctx->duration / AV_TIME_BASE % 3600 / 60;
  int const seconds = ctx->duration / AV_TIME_BASE % 60;

  printf("media duration = %llds (%02d:%02d:%02d)",
         ctx->duration / AV_TIME_BASE, hours, minutes, seconds);

  avformat_close_input(&ctx);
}

int main() {
  av_log_set_level(AV_LOG_DEBUG);
  av_log(NULL, AV_LOG_DEBUG, "HELLO, WORLD\n");
  SaveFrame();
  return 0;
}