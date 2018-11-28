class Actions extends Vanilla_Redux_Actions {
    /////
    ///// util
    /////
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
    /////
    ///// Maledict
    /////
    fetchMaledicts () {
        API.get('/maledicts', function (json, success) {
            if (!success)
                STORE.dispatch(this.fetchedMaledicts(json));
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

        API.get(path, function (json, success) {
            if (!success)
                STORE.dispatch(this.fetchedMaledictImpures(json));
        }.bind(this));
    }
    fetchedMaledictImpures (response) {
        return {
            type: 'FETCHED-MALEDICT-IMPURES',
            data: { impures: this.mergeData(response) },
        };
    }
    createMaledictImpures (maledict, data) {
        let path = '/maledicts/' + maledict.id + '/impures';

        API.post(path, data, function (json, success) {
            if (!success)
                STORE.dispatch(this.createdMaledictImpures(json, maledict));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    createdMaledictImpures (response, maledict) {
        return {
            type: 'CREATED-MALEDICT-IMPURES',
            data: {},
            maledict: maledict
        };
    }
    /////
    ///// Impure
    /////
    saveImpure (impure) {
        let path = '/impures/' + impure.id;

        API.post(path, impure, function (json, success) {
            if (!success)
                STORE.dispatch(this.savedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    savedImpure (impure) {
        return {
            type: 'SAVED-IMPURE',
            data: { impures: this.mergeData([impure]) },
        };
    }
    /////
    ///// Action
    /////
    startImpure (impure) {
        let path = '/impures/' + impure.id + '/purges/start';

        API.post(path, null, function (json, success) {
            if (!success)
                STORE.dispatch(this.startedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    startedImpure (impure) {
        return {
            type: 'STARTED-ACTION',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
        };
    }
    stopImpure (impure) {
        let path = '/impures/' + impure.id + '/purges/stop';

        API.post(path, null, function (json, success) {
            if (!success)
                STORE.dispatch(this.stopedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    stopedImpure (impure) {
        return {
            type: 'STOPED-ACTION',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
        };
    }
    finishImpure (impure) {
        let path = '/impures/' + impure.id + '/finish';

        API.post(path, null, function (json, success) {
            if (!success)
                STORE.dispatch(this.finishedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    finishedImpure (impure) {
        return {
            type: 'FINISHED-IMPURE',
            data: {},
        };
    }
    saveActionResult (action_result) {
        let path = '/purges/' + action_result.id + '/term';
        let data = {
            start: action_result.start,
            end: action_result.end
        };

        API.post(path, data, function (json, success) {
            if (!success)
                STORE.dispatch(this.savedActionResult(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    savedActionResult () {
        return {
            type: 'SAVED-ACTION-RESULT'
        };
    }
    /////
    ///// Move Impure to Maledict
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
    moveImpure (maledict, impure) {
        let path = '/maledicts/%d/impures/move'.format(maledict.id);

        API.post(path, impure, function (json, success) {
            if (!success)
                STORE.dispatch(this.movedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    movedImpure (impure) {
        return {
            type: 'MOVED-IMPURE',
            data: {},
        };
    }
    /////
    ///// Purge History
    /////
    fetchPurgeHistory () {
        API.get('/purges/history', function (json, success) {
            if (!success)
                STORE.dispatch(this.fetchedPurgeHistory(json));
        }.bind(this));
    }
    fetchedPurgeHistory (response) {

        for (let purge of response) {
            if (purge.start) purge.start = new Date(purge.start);
            if (purge.end)   purge.end   = new Date(purge.end);
        }
        return {
            type: 'FETCHED-PURGE-HISTORY',
            data: { purges: this.mergeData(response) },
        };
    }
    /////
    ///// Message
    /////
    pushMessage (message) {
        let new_messages = STORE.get('messages');
        new_messages.push(message);

        STORE.dispatch({
            type: 'PUSHED-MESSAGE',
            data: { messages: new_messages },
        });
    }
    pushFetchErrorMessage (json) {
        this.pushMessage({
            title: json['ERROR-TYPE'] + ' (' + json['CODE'] + ')',
            contents: json['MESSAGE'],
            type: 'danger',
            json: json,
        });
    };
    closeMessage (message) {
        let messages = STORE.get('messages');
        let new_messages = messages.filter((msg) => {
            return msg != message;
        });

        STORE.dispatch({
            type: 'CLOSED-MESSAGE',
            data: { messages: new_messages },
        });
    }
}
