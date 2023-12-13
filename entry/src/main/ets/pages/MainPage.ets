import { CommonConstants } from '../common/constant/CommonConstant'
import TargetInformation from '../view/TargetInformation'
import TargetList from '../view/TargetList';
import DataModel, { TaskItemBean } from '../viewmodel/DataModel';
import AddTargetDialog from '../view/AddTargetDialog'
import getCurrentTime from '../common/utils/DateUtil';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'
  @State targetData: Array<TaskItemBean> = DataModel.getData();
  @State latestUpdateDate: string = CommonConstants.DEFAULT_PROGRESS_VALUE
  @State totalTasksNumber: number = 0;
  @State completedTasksNumber: number = 0;
  @Provide @Watch('onProgressChanged') overAllProgressChanged: boolean = false;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddTargetDialog(
      {
        onClickOk: (value: string): void => {
          this.saveTask(value)
        }
      }
    ),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: CommonConstants.DIALOG_OFFSET_X,
      dy: $r('app.float.dialog_offset_y')
    },
    customStyle: true,
    autoCancel: false
  });

  onProgressChanged() {
    this.totalTasksNumber = this.targetData.length;
    this.completedTasksNumber = this.targetData.filter((item: TaskItemBean) => {
      return item.progressValue === CommonConstants.SLIDER_MAX_VALUE;
    }).length;
    this.latestUpdateDate = getCurrentTime();
  }

  build() {
    Column() {
      this.titleBar()
      TargetInformation({
        latestUpdateDate: this.latestUpdateDate,
        totalTasksNumber: this.totalTasksNumber,
        completedTaskNumber: this.completedTasksNumber
      })
      TargetList({
        targetData: $targetData,
        onAddClick: (): void => this.dialogController.open()
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

  saveTask(taskName: string) {
    if (taskName === '') {
      promptAction.showToast({
        message: $r('app.string.cannot_input_empty'),
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      })
      return;
    }
    DataModel.addData(new TaskItemBean(taskName, 0, getCurrentTime()))
    this.targetData = DataModel.getData();
    this.overAllProgressChanged = !this.overAllProgressChanged
    this.dialogController.close();
  }
}