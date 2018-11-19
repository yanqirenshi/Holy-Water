class Actions extends Vanilla_Redux_Actions {
    mergeData (source, target) {
        let target_ht;
        let target_list;

        if (target){
            target_ht = Object.assign({}, target.ht);
            target_list = target.list.slice();
        } else {
            target_ht = {};
            target_list = [];
        }

        for (var i in source) {
            let obj = source[i];

            if (target_ht[obj.id]) {
                let target_obj = target_ht[obj.id];
                for (var k in obj) {
                    target_obj[k] = obj[k];
                }
            } else {
                target_ht[obj.id] = obj;
                target_list.push(obj);
            }
        }
        return { ht: target_ht, list: target_list };
    }
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }
    fetchMaledicts () {
        API.get('/maledicts', function (response) {
            STORE.dispatch(this.fetchedMaledicts(response));
        }.bind(this));
    }
    fetchedMaledicts (response) {
        return {
            type: 'FETCHED-MALEDICTS',
            data: { maledicts: this.mergeData(response, STORE.get('maledicts')) },
        };
    }
    fetchMaledictImpures (maledict_id) {
        let path = '/maledicts/' + maledict_id + '/impures';

        API.get(path, function (response) {
            STORE.dispatch(this.fetchedMaledictImpures(response));
        }.bind(this));
    }
    fetchedMaledictImpures (response) {
        return {
            type: 'FETCHED-MALEDICT-IMPURES',
            data: { impures: this.mergeData(response) },
        };
    }
    createMaledictImpures (maledict_id, data) {
        let path = '/maledicts/' + maledict_id + '/impures';

        API.post(path, data, function (response) {
            STORE.dispatch(this.createdMaledictImpures(response));
        }.bind(this));
    }
    createdMaledictImpures (response) {
        return {
            type: 'CREATED-MALEDICT-IMPURES',
            data: { impures: this.mergeData(response) },
        };
    }
    /////
    ///// Action
    /////
    startAction (impure) {
        let path = '/impures/' + impure.id + '/purges/start';

        API.post(path, null, function (response) {
            STORE.dispatch(this.startedAction(response));
        }.bind(this));
    }
    startedAction (impure) {
        return {
            type: 'STARTED-ACTION',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
        };
    }
    stopAction (impure) {
        let path = '/impures/' + impure.id + '/purges/stop';

        API.post(path, null, function (response) {
            STORE.dispatch(this.startedAction(response));
        }.bind(this));
    }
    stopedAction (impure) {
        return {
            type: 'STOPED-ACTION',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
        };
    }
    /////
    /////
    /////
    startDragImpureIcon () {
        STORE.dispatch({
            type: 'START-DRAG-IMPURE-ICON',
            data: {},
        });
    }
    endDragImpureIcon () {
        STORE.dispatch({
            type: 'END-DRAG-IMPURE-ICON',
            data: {},
        });
    }

}
