import Logger from '../common/utils/Logger'

const TAG = '[DataModel]';

export class TaskItemBean {
  taskName: string;
  updateDate: string;
  progressValue: number;

  constructor(taskName: string, progressValue: number, updateDate: string) {
    this.taskName = taskName;
    this.updateDate = updateDate;
    this.progressValue = progressValue;
  }
}

export class DataModel {
  private targetData: Array<TaskItemBean> = [
  // {
  //   taskName: '目标一',
  //   updateDate: '2023/2/3 12:23:22',
  //   progressValue: 33
  // },
  // {
  //   taskName: '目标二',
  //   updateDate: '2023/2/3 12:23:22',
  //   progressValue: 33
  // },
  // {
  //   taskName: '目标三',
  //   updateDate: '2023/2/3 12:23:22',
  //   progressValue: 33
  // }
  ];

  getData(): Array<TaskItemBean> {
    return this.targetData;
  }

  updateProgress(index: number, updateValue: number, updateDate: string): boolean {
    if (!this.targetData[index]) {
      return false;
    }
    this.targetData[index].progressValue = updateValue;
    this.targetData[index].updateDate = updateDate;
    return true;
  }

  deleteData(selectArr: Array<boolean>) {
    if (!selectArr) {
      Logger.error(TAG, 'Failed to delete data because selectArr is ' + selectArr);
    }

  }

  addData(data: TaskItemBean) {
    if (!data) {
      Logger.error(TAG, 'addData error because data is: ' + data);
      return;
    }
    this.targetData.push(data);
  }
}

export default new DataModel();