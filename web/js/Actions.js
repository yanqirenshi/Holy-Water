class Actions extends Vanilla_Redux_Actions {
    mergeData (source, target) {
        let target_ht = Object.assign({}, target.ht);
        let target_list = target.list.slice();
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
            type: 'FETCHED-MALEDICTS',
            data: { maledicts: this.mergeData(response, STORE.get('maledicts')) },
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
            data: {},
        };
    }
}
