import relationalStore from '@ohos.data.relationalStore';
import { UIAbility, Context } from '@kit.AbilityKit';
import TaskInfo from '../viewmodel/TaskInfo';

// 将 UpdateTaskData 扩展为 ValuesBucket 类型
interface UpdateTaskData extends relationalStore.ValuesBucket {
  finished: boolean;
}

class TaskModel {

  private tableName: string = 'TASK';
  private rdbStore: relationalStore.RdbStore | null = null;  // 初始化为空

  // 初始化数据库
  initTaskDB(context: Context) {
    const config: relationalStore.StoreConfig = {
      name: 'MyApplication.db',
      securityLevel: relationalStore.SecurityLevel.S1,
    };
    const sql = `CREATE TABLE IF NOT EXISTS TASK (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                NAME TEXT NOT NULL,
                FINISHED bit
                );`


    relationalStore.getRdbStore(context, config, (err: Error | null, rdbStore: relationalStore.RdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败');
        return;
      }
      rdbStore.executeSql(sql);
      console.log('testTag', '创建 task 表成功');
      this.rdbStore = rdbStore;
    });
  }

  // 查询任务列表
  async getTaskList() {
    let predicates = new relationalStore.RdbPredicates(this.tableName);
    let result = await this.rdbStore?.query(predicates, ['ID', 'NAME', 'FINISHED']);

    if (!result) {
      console.log('查询结果为空');
      return [];
    }

    let tasks: TaskInfo[] = [];
    while (!result.isAtLastRow) {
      result?.goToNextRow();
      let id = result?.getLong(result.getColumnIndex('ID')) ?? 0;
      let name = result?.getString(result.getColumnIndex('NAME')) ?? '';
      let finished = result?.getLong(result.getColumnIndex('FINISHED'));

      let task = new TaskInfo(id, name);
      task.finished = !!finished;

      tasks.push(task);
    }
    console.log('testTag','查询的数据为', JSON.stringify(tasks));
    return tasks;
  }


  //新增
  // addTask(name:string){
  //   return  this.rdbStore?.insert(this.tableName,{name,finished:false})
  // }
  addTask(name: string): Promise<number> {
    return new Promise((resolve, reject) => {
      if (!this.rdbStore) {
        reject(new Error('RDB Store is not initialized.'));
        return;
      }

      this.rdbStore.insert(this.tableName, { NAME: name, FINISHED: false })
        .then((id: number) => {
          resolve(id);  // 返回插入后生成的 ID
        })
        .catch((err:Error) => {
          reject(err);
        });
    });
  }

  // 修改任务状态
  updateTaskStatus(id: number, finished: boolean) {
    // 1. 要更新的数据，构建符合 ValuesBucket 格式的对象
    let data: UpdateTaskData = { finished }; // 显式声明类型

    // 2. 更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName);
    predicates.equalTo('TD', id);

    // 3. 更新操作
    this.rdbStore?.update(data, predicates);  // 传入声明好的类型

  }

  // 删除任务
  deleteTaskById(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName);
    predicates.equalTo('TD', id);
    this.rdbStore?.delete(predicates);
  }
}

// 创建 TaskModel 实例
let taskModel = new TaskModel();

export default taskModel as TaskModel;
