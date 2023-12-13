import { CommonConstants } from '../common/constant/CommonConstant'

@Component
export default struct TargetInformation {
  build() {
    Column() {
      this.TargetItem()
    }
    .padding($r('app.float.target_padding'))
    .width(CommonConstants.MAIN_BOARD_WIDTH)
    .height($r('app.float.target_info_height'))
    .backgroundColor(Color.White)
    .borderRadius(CommonConstants.TARGET_BORDER_RADIUS)
  }

  @Builder
  TargetItem() {
    Row() {
      Image($r('app.media.ic_main'))
        .width($r('app.float.target_image_length'))
        .height($r('app.float.target_image_length'))
        .objectFit(ImageFit.Fill)
        .borderRadius(CommonConstants.IMAGE_BORDER_RADIUS)
      Column() {
        Text($r('app.string.target_name'))
          .fontSize($r('app.float.target_name_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .width(CommonConstants.TITLE_WIDTH)
        Text($r('app.string.target_info'))
          .opacityTextStyle()

      }
      .margin({
        left: CommonConstants.TARGET_MARGIN_LEFT
      })
      .alignItems(HorizontalAlign.Start)
    }
  }
}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}