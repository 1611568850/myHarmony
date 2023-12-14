import { CommonConstants } from '../common/constant/CommonConstant';
import getCurrentTime from '../common/utils/DateUtil';
import DataModel, { TaskItemBean } from '../viewmodel/DataModel'
import ProgressEditPanel from './ProgressEditPanel';

@Component
export default struct TargetListItem {
  private taskItem?: TaskItemBean;
  @State latestProgress?: number = 0;
  @Link @Watch('onClickIndexChanged') clickIndex: number;
  @State updateDate?: string = '';
  @Prop isEditMode: boolean;
  @Link selectArr: Array<boolean>;
  public index: number = 0;
  @State isExpanded: boolean = false;
  @State sliderMode: number = CommonConstants.DEFAULT_SLIDER_MODE;
  @Consume overAllProgressChanged: boolean

  aboutToAppear() {
    this.latestProgress = this.taskItem?.progressValue;
    this.updateDate = this.taskItem?.updateDate;
  }

  onClickIndexChanged() {
    if (this.clickIndex !== this.index) {
      this.isExpanded = false;
    }
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {

      Column() {
        this.targetItem()
        if (this.isExpanded) {
          Blank()
          ProgressEditPanel({
            slidingProgress: this.latestProgress,
            sliderMode: $sliderMode,
            onCancel: () => this.isExpanded = false,
            onClickOK: (progress: number): void => {
              this.latestProgress = progress;
              this.updateDate = getCurrentTime();
              let result = DataModel.updateProgress(this.index, this.latestProgress, this.updateDate)
              if (result) {
                this.overAllProgressChanged = !this.overAllProgressChanged
              }
              this.isExpanded = !this.isExpanded;
            }
          })
            .transition({
              scale: {
                x: CommonConstants.TRANSITION_ANIMATION_X,
                y: CommonConstants.TRANSITION_ANIMATION_Y
              }
            })
        }
      }
      .padding({
        left: $r('app.float.list_padding'),
        top: $r('app.float.list_padding_top'),
        bottom: $r('app.float.list_padding_bottom'),
        right: !this.isEditMode ? $r('app.float.list_padding_right') : $r('app.float.list_edit_padding')
      })
      .height(this.isExpanded ? $r('app.float.expanded_item_height') : $r('app.float.list_item_height'))
      .width(CommonConstants.FULL_HEIGHT)
      .borderRadius(CommonConstants.LIST_RADIUS)
      .animation({ duration: CommonConstants.DURATION })
      .backgroundColor(this.selectArr[this.index] ? $r('app.color.edit_blue') : Color.White)
      .opacity(
          this.latestProgress === CommonConstants.SLIDER_MAX_VALUE ?
        CommonConstants.OPACITY : CommonConstants.NO_OPACITY
      )
      .onClick(() => {
        if (this.sliderMode === CommonConstants.CLICK_SLIDER_MODE) {
          this.sliderMode = CommonConstants.DEFAULT_SLIDER_MODE;
          return;
        }
        if (!this.isExpanded) {
          animateTo({ duration: CommonConstants.DURATION }, () => {
            this.isExpanded = !this.isExpanded;
          })
          this.clickIndex = this.index
        }
      })

      Row() {
        Checkbox()
          .select(this.selectArr[this.index])
          .selectedColor($r('app.color.main_blue'))
          .width(this.isEditMode ? CommonConstants.CHECKBOX_WIDTH : 0)
          .margin({ right: $r('app.float.list_padding') })
          .onChange((isCheck: boolean) => {
            this.selectArr[this.index] = isCheck;
          })
          .animation({ duration: CommonConstants.DURATION ,delay:50})

      }
      .width(CommonConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.End)

    }
    .width(CommonConstants.FULL_WIDTH)
  }

  @Builder
  targetItem() {
    Row() {
      Text(this.taskItem?.taskName)
        .fontSize($r('app.float.list_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r('app.color.title_black_color'))
        .width(CommonConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(CommonConstants.MAX_LINES)
      Blank()
      Column() {
        Text(`${this.latestProgress}%`)
          .fontSize($r('app.float.list_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r('app.color.title_black_color'))
        Row() {
          Text($r('app.string.latest_updateTime'))
            .opacityTextStyle()
          Text(this.updateDate)
            .opacityTextStyle()
        }
        .margin({ top: $r('app.float.text_margin') })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
  }
}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}