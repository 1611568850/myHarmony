import { CommonConstants } from '../common/constant/CommonConstant';
import { TaskItemBean } from '../viewmodel/DataModel'

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

  onClickIndexChanged() {
    if (this.clickIndex !== this.index) {
      this.isExpanded = false;
    }
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Column() {
        this.targetItem()
      }
      .padding({
        left: $r('app.float.list_padding'),
        top: $r('app.float.list_padding_top'),
        bottom: $r('app.float.list_padding_bottom'),
        right: this.isEditMode ? $r('app.float.list_edit_padding') : $r('app.float.list_padding_right')
      })
      .height($r('app.float.list_item_height'))
      .width(CommonConstants.FULL_HEIGHT)
      .borderRadius(CommonConstants.LIST_RADIUS)
      .animation({ duration: CommonConstants.DURATION })
      .backgroundColor(Color.White)

      if (this.isEditMode) {
        Row() {
          Checkbox()
            .select(this.selectArr[this.index])
            .selectedColor($r('app.color.main_blue'))
            .width(CommonConstants.CHECKBOX_WIDTH)
            .margin({ right: $r('app.float.list_padding') })
            .onChange((isCheck: boolean) => {
              this.selectArr[this.index] = isCheck;
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.End)
      }
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