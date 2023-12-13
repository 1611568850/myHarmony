import { CommonConstants } from '../common/constant/CommonConstant'
import TargetInformation from '../view/TargetInformation'
import TargetList from '../view/TargetList';
import DataModel, { TaskItemBean } from '../viewmodel/DataModel';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'
  @State targetData: Array<TaskItemBean> = DataModel.getData();

  build() {
    Column() {
      this.titleBar()
      TargetInformation()
      TargetList({
        targetData: $targetData,
      })
        .height(CommonConstants.LIST_BOARD_HEIGHT)

    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.index_background'))
  }

  @Builder
  titleBar() {
    Text($r('app.string.title'))
      .width(CommonConstants.TITLE_WIDTH)
      .height($r('app.float.title_height'))
      .fontSize($r('app.float.title_font'))
      .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
      .textAlign(TextAlign.Start)
      .margin({
        top: $r('app.float.title_margin'),
        bottom: $r('app.float.title_margin')
      })

  }
}