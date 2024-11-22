import AbilityStage from '@ohos.app.ability.AbilityStage';
import Want from '@ohos.app.ability.Want';

export default class MyAbilityStage extends AbilityStage {//继承舞台
  onAcceptWant(want: Want): string {
    if(want.abilityName === 'DocumentAbility'){
      return `DocAbilityInstance_${want.parameters.instanceKey}`
    }
    return ''
  }
}