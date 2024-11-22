import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from '../components/CommonComponets'

@Entry
@Component
struct DocumentListPage {
  private index: number = 1
  @State docs: number[] = [] // 文档ID的数组

  // 确保 getContext 返回的类型是 common.UIAbilityContext
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({space: 10}) {
        Header({title: '文档列表'}) // 显示标题
        Divider() // 分隔符
        Button('新建文档')
          .onClick(() => {
            // 添加文档
            this.docs.push(this.index)

            //第一步12行
            // 第二步  跳转的目的地want，定义明确的 Want 类型
            let want: Want = {
              deviceId: '', // 目标设备ID
              bundleName: 'com.example.myapplication', // 应用包名
              moduleName: 'entry', // 模块名
              abilityName: 'DocumentAbility', // 目标能力名
              parameters: {
                instanceKey: 'idx_' + this.index++ // 文档的唯一标识符
              }
            }
            // 第三步：跳转到文档编辑能力
            this.context.startAbility(want)
          })

        // 遍历文档ID列表，生成文档项
        ForEach(this.docs, (id: number) => {
          Row({space: 10}) {
            Image($r('app.media.ic_files_doc'))
              .width(20)
            Text(`文档${id}`)
              .fontSize(18)
              .onClick(() => {
                // 跳转到文档编辑的 UIAbility
                let want: Want = {
                  deviceId: '',
                  bundleName: 'com.example.myapplication',
                  moduleName: 'entry',
                  abilityName: 'DocumentAbility',
                  parameters: {
                    instanceKey: 'idx_' + id
                  }
                }
                // 跳转
                this.context.startAbility(want)
              })
          }
          .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(20)
    }
  }
}
