class Actions extends Vanilla_Redux_Actions {
    constructor () {
        super();

        this.last_notif_time = new Date();
    }
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
        let state = STORE.get('site');

        // Page は選択された route の根なので "[0]" を指定。
        state.active_page = data.route[0];

        STORE.dispatch({
            type: 'MOVE-PAGE',
            data: { site: state },
            route: data.route,
        });
    }
    encodePostData (data_ht) {
        if (!data_ht) return {};

        let out = Object.assign({}, data_ht);
        for (let key in out) {
            let val = out[key];

            if (key=='description' || key=='name')
                val = val ? '' : val.trim();

            out[key] = encodeURIComponent(out[key]);
        }

        return out;
    }
    /////
    ///// HolyWater
    /////
    fetchHolyWater () {
        API.get('/holy-water', function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedHolyWater(json));
        }.bind(this));
    }
    fetchedHolyWater (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-HOLYWATER',
            data: {
                orthodoxs: this.mergeData(response.ORTHODOXS, state.orthodoxs),
                maledicts: this.mergeData(response.MALEDITDS, state.maledicts),
                deamons:   this.mergeData(response.DEAMONS, state.deamons),
                deccots:   this.mergeData(response.DECCOTS, state.deccots),
                profiles:  response.PROFILES,
            },
        };
    }
    /////
    ///// Angels
    /////
    fetchAngels () {
        API.get('/angels', function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedAngels(json));
        }.bind(this));
    }
    fetchedAngels (response) {
        return {
            type: 'FETCHED-ANGELS',
            data: { angels: this.mergeData(response, STORE.get('angels')) },
        };
    }
    signOut () {
        let path = '/sign/out';

        API.post(path, {}, function (json, success) {
            if (success)
                location.pathname = '/hw/sign/in/';
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    /////
    ///// orthodoxs
    /////
    fetchOrthodoxs () {
        API.get('/orthodoxs', function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedOrthodoxs(json));
        }.bind(this));
    }
    fetchedOrthodoxs (response) {
        return {
            type: 'FETCHED-ORTHODOXS',
            data: {
                orthodoxs: this.mergeData(response, STORE.get('orthodoxs')),
            },
        };
    }
    fetchOrthodoxExorcists (id) {
        API.get('/orthodoxs/' + id + '/exorcists', function (response) {
            STORE.dispatch(this.fetchedOrthodoxExorcists(response));
        }.bind(this));
    }
    fetchedOrthodoxExorcists (response) {
        return {
            type: 'FETCHED-ORTHODOX-EXORCISTS',
            data: { angels: this.mergeData(response, STORE.get('angels')) },
            exorcists: response
        };
    }
    fetchOrthodoxAllExorcists () {
        API.get('/orthodoxs/exorcists', function (response) {
            STORE.dispatch(this.fetchedOrthodoxAllExorcists(response));
        }.bind(this));
    }
    fetchedOrthodoxAllExorcists (response) {
        return {
            type: 'FETCHED-ORTHODOX-ALL-EXORCISTS',
            data: { angels: this.mergeData(response, STORE.get('angels')) },
        };
    }
    /////
    ///// Maledict
    /////
    fetchMaledicts () {
        API.get('/maledicts', function (json, success) {
            if (success)
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
            if (success)
                STORE.dispatch(this.fetchedMaledictImpures(json));
        }.bind(this));
    }
    fetchedMaledictImpures (response) {
        return {
            type: 'FETCHED-MALEDICT-IMPURES',
            data: { impures: this.mergeData(response) },
        };
    }
    selectedHomeMaledict (maledict) {
        let state = STORE.get('selected');

        state.home.maledict = maledict;

        STORE.dispatch({
            type: 'SELECTED-HOME-MALEDICT',
            data: {
                selected: state
            },
        });
    }
    selectedHomeMaledictWatingFor (maledict) {
        let state = STORE.get('selected');

        state.home.maledict = maledict;

        STORE.dispatch({
            type: 'SELECTED-HOME-MALEDICT-WATING-FOR',
            data: {
                selected: state
            },
        });
    }
    selectedHomeMaledictMessages (maledict) {
        let state = STORE.get('selected');

        state.home.maledict = maledict;

        STORE.dispatch({
            type: 'SELECTED-HOME-MALEDICT-MESSAGES',
            data: {
                selected: state
            },
        });
    }
    /////
    ///// Deamons
    /////
    fetchDeamons () {
        let path = '/deamons';

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedDeamons(json));
        }.bind(this));
    }
    fetchedDeamons (response) {
        return {
            type: 'FETCHED-DEAMONS',
            data: { deamons: this.mergeData(response, STORE.get('deamons')) },
        };
    }
    openModalCreateDeamon () {
        STORE.dispatch({
            type: 'OPEN-MODAL-CREATE-DEAMON',
        });
    }
    createDeamon (name, name_short, description) {
        let path = '/deamons';
        let post_data = {
            name: name,
            name_short: name_short,
            description: description,
        };

        API.post(path, this.encodePostData(post_data), (json, success) => {
            STORE.dispatch(this.createdDeamon(json));
        });
    }
    createdDeamon (response) {
        this.pushSuccessMessage('Deamon の作成が完了しました');

        return {
            type: 'CREATED-DEAMON',
            data: {},
        };
    }
    updateDeamonName (deamon, name) {
        let path = '/deamons/%d/name'.format(deamon.id);
        let post_data = {
            name: name,
        };
        API.post(path, this.encodePostData(post_data), (json, success) => {
            if (success)
                STORE.dispatch(this.updatedDeamonName(json, deamon));
            else
                this.pushFetchErrorMessage(json);
        });
    }
    updatedDeamonName (response, deamon) {
        this.pushSuccessMessage('Deamon の Name の変更が完了しました');

        return {
            type: 'UPDATED-DEAMON-NAME',
            data: {},
            deamon: deamon,
        };
    }
    updateDeamonDescription (deamon, description) {
        let path = '/deamons/%d/description'.format(deamon.id);
        let post_data = {
            description: description,
        };
        API.post(path, this.encodePostData(post_data), (json, success) => {
            if (success)
                STORE.dispatch(this.updatedDeamonDescription(json));
            else
                this.pushFetchErrorMessage(json);
        });
    }
    updatedDeamonDescription (response) {
        this.pushSuccessMessage('Deamon の Description の変更が完了しました');

        return {
            type: 'UPDATED-DEAMON-DESCRIPTION',
            data: {},
        };
    }
    purgeDeamon (deamon) {
        let path = '/deamons/%d/purge'.format(deamon.id);

        API.post(path, null, (json, success) => {
            if (success)
                STORE.dispatch(this.purgedDeamon(json));
            else
                this.pushFetchErrorMessage(json);
        });
    }
    purgedDeamon (response) {
        this.pushSuccessMessage('Deamon の Purgeが完了しました');

        return {
            type: 'PURGE-DEAMON',
            data: {},
        };
    }
    /////
    ///// Impure
    /////
    fetchImpure (id) {
        let path = '/impures/' + id;

        API.get(path, function (json, success) {
            STORE.dispatch(this.fetchedImpure(json));
        }.bind(this));
    }
    fetchedImpure (response) {
        let impure = response;

        let data = [];
        if (impure._class=='RS_IMPURE-ACTIVE')
            data.push(impure);

        return {
            type: 'FETCHED-IMPURE',
            data: { impures: this.mergeData(data, STORE.get('impures')) },
            impure: response,
        };
    }
    fetchDoneImpures (from, to) {
        let path_str = '/impures/status/done?from=%s&to=%s';
        let path = path_str.format(from.toISOString(), to.toISOString());

        API.get(path, function (json, success) {
            if (!success) {
                console.warn('See: http://satoshi-iwasaki.local:8080/hw/#home/impures/1197');
                console.warn([from, to]);
                this.pushFetchErrorMessage(json);
                return;
            }

            STORE.dispatch(this.fetchedDoneImpures(json));
        }.bind(this));
    }
    fetchedDoneImpures (response) {
        return {
            type: 'FETCHED-DONE-IMPURES',
            data: { impures_done: this.mergeData(response, STORE.get('impures_done')) },
        };
    }
    saveImpure (impure) {
        let path = '/impures/' + impure.id;

        API.post(path, this.encodePostData(impure), function (json, success) {
            if (!success) {
                this.pushFetchErrorMessage(json);
                return;
            }

            STORE.dispatch(this.savedImpure(json));
            this.pushSuccessMessage('Impure の更新が完了しました。');
        }.bind(this));
    }
    savedImpure (impure) {
        return {
            type: 'SAVED-IMPURE',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
        };
    }
    fetchImpurePurging () {
        let path = '/impures/purging';

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedImpurePurging(json));
        }.bind(this));
    }
    fetchedImpurePurging (response) {
        let state = STORE.get('purging');

        state.impure = response;

        return {
            type: 'FETCHED-IMPURE-PURGING',
            data: { purging: state },
        };
    }
    finishImpure (impure, with_stop, spell) {
        let path = '/impures/' + impure.id + '/finish';
        let post_data = {
            'with-stop': (with_stop==true ? true : false),
            spell: spell,
        };

        API.post(path, this.encodePostData(post_data), function (json, success) {
            if (success)
                STORE.dispatch(this.finishedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    finishedImpure (impure) {
        return {
            type: 'FINISHED-IMPURE',
            data: {},
            impure: impure,
        };
    }
    startTransferImpureToAngel (impure, angel) {
        STORE.dispatch({
            type: 'START-TRANSFERD-IMPURE-TO-ANGEL',
            contents: {
                impure:  impure,
                angel:   angel,
            }
        });
    }
    stopTransferImpureToAngel () {
        STORE.dispatch({
            type: 'START-TRANSFERD-IMPURE-TO-ANGEL',
        });
    }
    transferImpureToAngel (impure, angel, message) {
        if (!(impure && angel))
            throw new Error('akan');

        let path = '/impures/%s/transfer/angel/%s'.format(impure.id, angel.id);
        let post_data = {
            message: encodeURIComponent(message),
        };

        API.post(path, post_data, (json, success) => {
            STORE.dispatch(this.transferdImpureToAngel(json));
        });
    }
    transferdImpureToAngel () {
        this.pushSuccessMessage('Impure の依頼が完了しました。');

        return {
            type: 'TRANSFERD-IMPURE-TO-ANGEL'
        };
    }
    createImpureAfterImpure (impure, data) {
        let path = '/impures/' + impure.id + '/afters';

        API.post(path, this.encodePostData(data), (json, success) => {
            STORE.dispatch(this.createdImpureAfterImpure(json, impure));
        });
    }
    createdImpureAfterImpure (response, from_impure) {
        this.pushSuccessMessage('Impure の作成が完了しました');

        return {
            type: 'CREATED-IMPURE-AFTER-IMPURE',
            data: {},
            from: from_impure,
            to:   response,
        };
    }
    createImpureDeamonImpure (deamon, data) {
        let path = '/deamons/' + deamon.id + '/impures';

        API.post(path, this.encodePostData(data), (json, success) => {
            STORE.dispatch(this.createdImpureDeamonImpure(json, deamon));
        });
    }
    createdImpureDeamonImpure (response, deamon) {
        this.pushSuccessMessage('Impure の作成が完了しました');

        return {
            type: 'CREATED-IMPURE-DEAMON-IMPURE',
            data: {},
            deamon: deamon,
        };
    }
    setImpureDeamon (impure, deamon) {
        let path = '/impures/%d/deamons'.format(impure.id);
        let post_data = {
            deamon: {
                id: deamon.id,
            }
        };

        API.post(path, post_data, (json, success) => {
            STORE.dispatch(this.setedImpureDeamon(json, impure));
        });
    }
    setedImpureDeamon (response, impure) {
        this.pushSuccessMessage('Impure と Deamon の関連付けが完了しました。');

        return {
            type: 'SETED-IMPURE-DEAMON',
            data: {},
            impure: impure,
        };
    }
    fetchImpureAtWaitingFor () {
        let path = '/impures?waiting-for=true';

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedImpureAtWaitingFor(json));
        }.bind(this));
    }
    fetchedImpureAtWaitingFor (response) {
        return {
            type: 'FETCHED-IMPURE-AT-WAITING-FOR',
            response: response,
        };
    }
    updateImpureDescription (impure, description) {
        let path = '/impures/%d/description'.format(impure.id);
        let post_data = {
            description: description,
        };

        API.post(path, this.encodePostData(post_data), (json, success) => {
            if (success)
                STORE.dispatch(this.updatedImpureDescription(json, impure));
            else
                this.pushFetchErrorMessage(json);
        });
    }
    updatedImpureDescription (response, impure) {
        this.pushSuccessMessage('Impure の Description の変更が完了しました');

        return {
            type: 'UPDATED-IMPURE-DESCRIPTION',
            data: {},
            impure: impure,
        };
    }
    /////
    ///// Action
    /////
    startImpure (impure) {
        let path = '/impures/' + impure.id + '/purges/start';

        API.post(path, null, function (json, success) {
            if (success)
                STORE.dispatch(this.startedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    startedImpure (response) {
        let impure = response.impure_started;
        this.pushSuccessMessage('' +
                                'Impure の Purge を開始しました。\n'+
                                '■ Impure\n' +
                                ' ' + impure.name);

        let impure_started = response.impure_started;
        let impure_stopped = response.impure_stopped;

        let impures = [impure_started];
        if (impure_stopped)
            impures.push(impure_stopped);

        return {
            type: 'STARTED-ACTION',
            data: {
                impures: this.mergeData(impures, STORE.get('impures'))
            },
            impure: impure_started,
        };
    }
    stopImpure (impure) {
        let path = '/impures/' + impure.id + '/purges/stop';

        API.post(path, null, function (json, success) {
            if (success)
                STORE.dispatch(this.stopedImpure(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    stopedImpure (impure) {
        this.pushSuccessMessage('' +
                                'Impure の Purge を停止しました。\n'+
                                '■ Impure\n' +
                                ' ' + impure.name);
        return {
            type: 'STOPED-ACTION',
            data: { impures: this.mergeData([impure], STORE.get('impures')) },
            impure: impure,
        };
    }
    saveActionResult (action_result) {
        let path = '/purges/' + action_result.id + '/term';
        let data = {
            start: action_result.start,
            end: action_result.end
        };

        API.post(path, data, function (json, success) {
            if (success)
                STORE.dispatch(this.savedActionResult(json));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    savedActionResult () {
        ACTIONS.pushSuccessMessage('Purge の実績の変更が完了しました。');

        return {
            type: 'SAVED-ACTION-RESULT'
        };
    }
    confirmationAttainImpure (impure) {
        STORE.dispatch({
            type: 'CONFIRMATION-ATTAIN-IMPURE',
            impure: impure,
        });
    }
    openModalSpellImpure (impure) {
        STORE.dispatch({
            type: 'OPEN-MODAL-SPELL-IMPURE',
            impure: impure,
        });
    }
    openModalCreateAfterImpure (impure) {
        STORE.dispatch({
            type: 'OPEN-MODAL-CREATE-AFTER-IMPURE',
            impure: impure,
        });
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

        API.post(path, this.encodePostData(impure), function (json, success) {
            if (success)
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
    ///// Sevices
    /////
    selectServiceItem (data) {
        let new_state = STORE.get('selected');
        let new_home_state = Object.assign({}, new_state.home);

        new_home_state.maledict = null;
        new_home_state.service  = data;

        new_state.home = new_home_state;

        STORE.dispatch({
            type: 'SELECT-SERVICE-ITEM',
            data: {
                selected: new_state
            },
        });
    }
    fetchServiceItems (service, deccot_id) {
        let path_str = '/deccots/%s/%s/items';
        let path = path_str.format(service, deccot_id);

        API.get(path, (response) => {
            STORE.dispatch(this.fetchedServiceItems(response));
        });
    }
    fetchedServiceItems (response) {
        return {
            type: 'FETCHED-SERVICE-ITEMS',
            data: { gitlab: this.mergeData(response, STORE.get('gitlab')) },
        };
    }
    /////
    ///// Request Message
    /////
    fetchRequestMessages () {
        let path = '/requests/messages';

        API.get(path, (response) => {
            STORE.dispatch(this.fetchedRequestMessages(response));
        });
    }
    fetchedRequestMessages (response) {
        return {
            type: 'FETCHED-REQUESTS-MESSAGES',
            response: response
        };
    }
    fetchRequestMessagesUnread () {
        let path = '/angels/request/messages/unread';

        API.get(path, (response) => {
            STORE.dispatch(this.fetchedRequestMessagesUnread(response));
        });
    }
    fetchedRequestMessagesUnread (response) {
        let state = STORE.get('request');

        let new_state = { messages: Object.assign({}, state.messages) };
        new_state.messages.unread = this.mergeData(response, { ht: {}, list: [] });

        return {
            type: 'FETCHED-REQUEST-MESSAGES-UNREAD',
            data: {
                requests: new_state,
            },
        };
    }
    changeToReadRequestMessage (id) {
        let path = '/requests/messages/' + id;

        API.post(path, null, (response) => {
            STORE.dispatch(this.changedToReadRequestMessage(response));
        });
    }
    changedToReadRequestMessage (response) {
        let state = STORE.get('requests');
        let new_unreads = state.messages.unread.list.filter((d) => {
            return response.id != d.id;
        });

        let new_state = { messages: Object.assign({}, state.messages) };
        new_state.messages.unread = this.mergeData(new_unreads, { ht: {}, list: [] });

        return {
            type: 'CHANGED-TO-READ-REQUEST-MESSAGE',
            data: {
                requests: new_state,
            },
        };
    }
    notifyNewMessages () {
        let now = moment(new Date());
        let befor = moment(this.last_notif_time);

        let distance_sec = Math.floor(now.diff(befor) / 1000);

        if (distance_sec < 5)
            return;

        let messages = STORE.get('requests.messages.unread.list').filter((d) => {
            let messaged_at = moment(d.messaged_at);

            return messaged_at.diff(befor) > 0;
        });

        this.last_notif_time = new Date();

        if (messages.length==0)
            return;

        this.pushWarningMessage('新規の依頼が ' + messages.length + ' 件届きました。');
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
            accrual_time: moment()
        });
    };
    pushErrorMessage (msg) {
        this.pushMessage({
            title: 'ERror',
            contents: msg,
            type: 'danger',
            accrual_time: moment(),
        });
    };
    pushSuccessMessage (message) {
        this.pushMessage({
            title: 'Success',
            contents: message,
            type: 'success',
            accrual_time: moment()
        });
    }
    pushWarningMessage (message) {
        this.pushMessage({
            title: 'Warning',
            contents: message,
            type: 'warning',
            accrual_time: moment()
        });
    }
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
    closePastedMessage () {
        let list = STORE.get('messages');

        let new_messages = [];
        for (let msg of list) {
            let past_time_ms = moment().diff(msg.accrual_time);
            let threshold_ms = 1 * 1000;

            if ((msg.type=='success' || msg.type=='warning') &&
                past_time_ms < threshold_ms)
                new_messages.push(msg);

            if (!(msg.type=='success' || msg.type=='warning'))
                new_messages.push(msg);
        }

        STORE.dispatch({
            type: 'CLOSED-MESSAGE',
            data: { messages: new_messages },
        });
    }
    /////
    ///// impure Incantation
    /////
    saveImpureIncantationSolo (impure, spell) {
        let path = '/impures/%s/incantation'.format(impure.id);
        let data = {
            spell: spell
        };

        API.post(path, this.encodePostData(data), function (response, success) {
            if (success) {
                this.pushSuccessMessage('呪文の詠唱が完了しました。');
                STORE.dispatch(this.savedImpureIncantationSolo(response, impure));
            } else {
                this.pushFetchErrorMessage(response);
            }
        }.bind(this));
    }
    savedImpureIncantationSolo (response, impure) {
        return {
            type: 'SAVED-IMPURE-INCANTATION-SOLO',
            impure: impure,
        };
    }
    /////
    ///// Page
    /////
    fetchPagesOrthodox (orthodox) {
        let path = '/pages/orthodoxs/%s'.format(orthodox.id);

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesOrthodox(json));
        }.bind(this));
    }
    fetchedPagesOrthodox (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-ORTHODOX',
            data: {},
            response: response,
        };
    }
    fetchPagesWarHistory (start, end) {
        let path = '/pages/war-history?';

        path += 'start=' + start.format('YYYY-MM-DD');
        path += '&';
        path += 'end='   + end.format('YYYY-MM-DD');

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesWarHistory(json));
        }.bind(this));
    }
    fetchedPagesWarHistory (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-WAR-HISTORY',
            data: {},
            response: response
        };
    }
    fetchPagesPurges (start, end) {
        let path = '/pages/purges?';

        path += 'from=' + moment(start).format('YYYY-MM-DD');
        path += '&';
        path += 'to='   + moment(end).format('YYYY-MM-DD');

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesPurges(json));
        }.bind(this));
    }
    fetchedPagesPurges (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-PURGES',
            data: {},
            response: response
        };
    }
    fetchPagesCemeteries (start, end) {
        let path = '/pages/cemeteries?';

        path += 'from=' + moment(start).format('YYYY-MM-DD');
        path += '&';
        path += 'to='   + moment(end).format('YYYY-MM-DD');

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesCemeteries(json));
        }.bind(this));
    }
    fetchedPagesCemeteries (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-CEMETERIES',
            data: {},
            response: response
        };
    }
    fetchPagesImpure (impure) {
        let path = '/pages/impures/' + impure.id ;
        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesImpure(json));
        }.bind(this));
    }
    fetchedPagesImpure (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-IMPURE',
            data: {},
            response: response
        };
    }
    fetchPagesHomeRequests () {
        let path = '/pages/requests';

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesHomeRequests(json));
        }.bind(this));
    }
    fetchedPagesHomeRequests (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-HOME-REQUESTS',
            response: response
        };
    }
    fetchPagesImpures (maledict_id) {
        let path = '/pages/impures?maledict-id=' + maledict_id;

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesImpures(json));
        }.bind(this));
    }
    fetchedPagesImpures (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-IMPURES',
            response: response
        };
    }
    fetchPagesImpureWaiting (impure) {
        let path = '/pages/impures/%d/waiting'.format(impure.id);
        dump(path);
        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesImpureWaiting(json));
        }.bind(this));
    }
    fetchedPagesImpureWaiting (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-IMPURE-WAITING',
            response: response
        };
    }
    fetchPagesDeamon (deamon) {
        let path = '/pages/deamons/%d'.format(deamon.id);

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesDeamon(json));
        }.bind(this));
    }
    fetchedPagesDeamon (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-DEAMON',
            response: response
        };
    }
    fetchPagesSelf (from, to) {
        let path = '/pages/self?from=%s&to=%s'.format(from.toISOString(), to.toISOString());

        API.get(path, function (json, success) {
            if (success)
                STORE.dispatch(this.fetchedPagesSelf(json));
        }.bind(this));
    }
    fetchedPagesSelf (response) {
        let state = STORE.state().toJS();

        return {
            type: 'FETCHED-PAGES-SELF',
            response: response
        };
    }
    /////
    ///// Page
    /////
    openModalCreateImpure (maledict) {
        STORE.dispatch({
            type: 'OPEN-MODAL-CREATE-IMPURE',
            maledict: maledict,
        });
    }
    closeModalCreateImpure () {
        STORE.dispatch({
            type: 'CLOSE-MODAL-CREATE-IMPURE',
        });
    }
    createMaledictImpure (maledict, data) {
        let path = '/maledicts/' + maledict.id + '/impures';

        API.post(path, this.encodePostData(data), function (json, success) {
            if (success)
                STORE.dispatch(this.createdMaledictImpure(json, maledict));
            else
                this.pushFetchErrorMessage(json);
        }.bind(this));
    }
    createdMaledictImpure (response, maledict) {
        this.pushSuccessMessage('Impure の作成が完了しました');

        return {
            type: 'CREATED-MALEDICT-IMPURE',
            data: {},
            maledict: maledict
        };
    }
    openModalPuregeDeamon (deamon) {
        STORE.dispatch({
            type: 'OPEN-MODAL-PUREGE-DEAMON',
            deamon: deamon,
        });
    }
    openModalCreateDeamonImpure (deamon) {
        STORE.dispatch({
            type: 'OPEN-MODAL-CREATE-DEAMON-IMPURE',
            deamon: deamon,
        });
    }
    /////
    ///// Page: Home
    /////
    switchLargeHomeImpureCard (impure) {
        let state = STORE.get('pages');

        state.home.card.impure.opened[impure.id] = impure;

        STORE.dispatch({
            type: 'SWITCH-LARGE-HOME-IMPURE-CARD',
            data: { pages: state },
        });
    }
    switchSmallHomeImpureCard (impure) {
        let state = STORE.get('pages');

        delete state.home.card.impure.opened[impure.id];

        STORE.dispatch({
            type: 'SWITCH-SMALL-HOME-IMPURE-CARD',
            data: { pages: state },
        });
    }
}
