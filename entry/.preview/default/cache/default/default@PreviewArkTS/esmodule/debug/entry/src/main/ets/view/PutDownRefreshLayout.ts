if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PutDownRefresh_Params {
    refreshText?: Resource;
}
import * as commonConst from "@bundle:com.example.list_harmony/entry/ets/common/CommonConstants";
export default class PutDownRefresh extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__refreshText = new SynchedPropertyObjectTwoWayPU(params.refreshText, this, "refreshText");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: PutDownRefresh_Params) {
    }
    updateStateVars(params: PutDownRefresh_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__refreshText.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__refreshText.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __refreshText: SynchedPropertySimpleOneWayPU<Resource>;
    get refreshText() {
        return this.__refreshText.get();
    }
    set refreshText(newValue: Resource) {
        this.__refreshText.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("entry/src/main/ets/view/PutDownRefreshLayout.ets(23:5)", "entry");
            Row.justifyContent(FlexAlign.Center);
            Row.width(commonConst.GOODS_LIST_WIDTH);
            Row.height(commonConst.GOODS_LIST_HEIGHT);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777222, "type": 20000, params: [], "bundleName": "com.example.list_harmony", "moduleName": "entry" });
            Image.debugLine("entry/src/main/ets/view/PutDownRefreshLayout.ets(24:7)", "entry");
            Image.width(commonConst.ICON_WIDTH);
            Image.height(commonConst.ICON_HEIGHT);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.refreshText);
            Text.debugLine("entry/src/main/ets/view/PutDownRefreshLayout.ets(27:7)", "entry");
            Text.fontSize(commonConst.NORMAL_FONT_SIZE);
        }, Text);
        Text.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
