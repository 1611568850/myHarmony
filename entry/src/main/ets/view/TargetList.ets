import TargetListItem from './TargetListItem';
import DataModel, { TaskItemBean } from '../viewmodel/DataModel';
import { CommonConstants } from '../common/constant/CommonConstant';

@Component
export default struct TargetList {
  @State isEditMode: boolean = false;
  @Link targetData: Array<TaskItemBean>;
  @State selectArray: Array<boolean> = [];
  @State selectAll: boolean = false;
  @State clickIndex: number = CommonConstants.DEFAULT_CLICK_INDEX;

  build() {
    Column() {
      Row() {
        Text($r('app.string.sub_goals'))
          .fontSize($r('app.float.secondary_title'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .fontColor($r('app.color.title_black_color'))
        Blank()
        if (this.targetData.length > 0) {
          if (this.isEditMode) {
            Text($r('app.string.cancel_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({ left: $r('app.float.operate_button_margin') })
              .onClick(() => {
                this.isEditMode = !this.isEditMode
              })
            Text($r('app.string.select_all_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .margin({
                left: $r('app.float.operate_button_margin')
              })

            Checkbox()
              .select(this.isSelectAll())
              .selectedColor($r('app.color.main_blue'))
              .width(CommonConstants.CHECKBOX_WIDTH)
              .onClick(() => {
                this.selectAll = !this.selectAll
                this.selectAllOrCancel(this.selectAll)
              })

          } else {
            Text($r('app.string.edit_button'))
              .operateTextStyle($r('app.color.main_blue'))
              .onClick(() => {
                this.isEditMode = !this.isEditMode
              })
          }
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r('app.float.history_line_height'))
      .padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding_right')
      })

      List({ space: CommonConstants.LIST_SPACE }) {
        ForEach(this.targetData, (item: TaskItemBean, index: number | undefined) => {
          ListItem() {
            TargetListItem({
              taskItem: item,
              index: index,
              isEditMode: this.isEditMode,
              selectArr: $selectArray,
              clickIndex: $clickIndex

            })
          }
        })
      }
      .edgeEffect(EdgeEffect.None)
      .margin({ top: $r('app.float.list_margin_top') })
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.LIST_HEIGHT)
    }
    .width(CommonConstants.MAIN_BOARD_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .padding({ top: $r('app.float.operate_row_margin') })
  }

  isSelectAll(): boolean {
    if (this.selectArray.length === 0) {
      return false
    }
    let deSelectCount: Length = this.selectArray.filter((selected: boolean) => selected === false).length
    if (deSelectCount === 0) {
      this.selectAll = true;
      return true
    }
    return false
  }
  selectAllOrCancel(selectStatus: boolean) {
    let newSelectArray: Array<boolean> = [];
    this.targetData.forEach(() => {
      newSelectArray.push(selectStatus);
    });
    this.selectArray = newSelectArray;
  }
}

@Extend(Text) function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.text_button_font'))
  .fontColor(color)
  .lineHeight($r('app.float.text_line_height'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
}

/**
 * Custom button style.
 */
@Extend(Button) function operateButtonStyle(color: Resource) {
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor($r('app.color.button_background'))
}