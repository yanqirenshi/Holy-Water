class HolyWater {
    constructor () {
        this.ts = new TimeStripper();
    }
    /////
    ///// Utilities
    /////
    summaryPurges (purges) {
        return purges.reduce((a,b) => {
            return a + b.elapsed_time;
        }, 0.0);
    }
    getDeamonInImpureName (impure_name) {
        let pos = impure_name.indexOf('：');

        return (pos==-1) ? 'other' : impure_name.substring(0,pos);
    }
    makeGunntChartData (core) {
        return {
            _class: 'WORKPACKAGE',
            _id: core.purge_id,
            code: core.impure_id,
            name: core.impure_name,
            uri: '',
            schedule: {
                start: moment(core.purge_start),
                 end: moment(core.purge_end),
            },
            children: { ht: {}, list: [] },
            _core: core,
        };
    }
    _makeGunntChartData (core) {
        return {
            _class: 'WORKPACKAGE',
            _id: core.id,
            code: core.impure_id,
            name: core.impure_name,
            uri: '',
            schedule: {
                start: core.start,
                end: core.end,
            },
            children: { ht: {}, list: [] },
            _core: core,
        };
    }
    str2yyyymmddhhmmss (v) {
        if(!v)
            return '';

        return moment(v).format('YYYY-MM-DD HH:mm:ss');
    }
    str2week (v) {
        if(!v)
            return '';

        return moment(v).format('ddd');
    }
    descriptionViewShort (v) {
        if(!v)
            return '';

        let lines = v.split('\n').filter((d) => {
            return d.trim().length > 0;
        });

        let suffix = '';
        if (lines.length>1 || lines[0].length>33)
            suffix = '...';

        let val = lines[0];
        if (val.length>33)
            val = val.substring(0,33);

        return val + suffix;
    }
    int2hhmmss (v) {
        return this.ts.format_sec(v);
    }
    htVal (keys_str, ht) {
        if (!keys_str)
            return null;

        let keys = keys_str.split('.');
        let val = ht;

        for (let key in keys) {
            val = ht[key];

            if (!val)
                return null;
        }

        return val;
    }
    /////
    ///// page-impure
    /////
    pageImpureContentsList (source) {
        let out = [];

        out.push({
            type: 'IMPURE-DESCRIPTION',
            contents: source,
        });

        out.push({
            type: 'IMPURE-DEAMON',
            contents: source,
        });

        out.push({
            type: 'IMPURE-STATUS',
            contents: source,
        });

        out.push({
            type: 'IMPURE-ANGEL',
            contents: source,
        });

        out.push({
            type: 'IMPURE-MALEDICT',
            contents: source,
        });

        out.push({
            type: 'IMPURE-STATUS-PURGE',
            contents: source,
        });

        let tmp = [];
        tmp = tmp.concat(source.purges.map((d) => {
            let date_str = d.end || d.start;


            return {
                type: 'IMPURE-PURGE',
                contents: d,
                time: new Date(date_str),
            };
        }));
        tmp = tmp.concat(source.spells.map((d) => {
            return {
                type: 'IMPURE-SPELL',
                contents: d,
                time: new Date(d.incantation_at),
            };
        }));
        tmp = tmp.concat(source.requests.map((d) => {
            return {
                type: 'IMPURE-REQUEST',
                contents: d,
                time: new Date(d.messaged_at),
            };
        }));

        tmp.push({
            type: 'IMPURE-NETWORK',
            contents: source,
        });

        return []
            .concat(out)
            .concat(tmp.sort((a, b) => {
                return a.time > b.time ? -1 : 1;
            }));
    }
    /////
    ///// page-deamon
    /////
    pageDeamonContentsList (source) {
        let out = [];

        let deamon  = source.deamon;
        let impures = source.impures;
        let impure_purge_times = source.impure_purge_times.reduce((ht, d) => {
            ht[d.impure_id] = d;
            return ht;
        }, {});

        out.push({
            type: 'DEAMON-DESCRIPTION',
            contents: source,
        });

        out.push({
            type: 'DEAMON-CODE',
            contents: source,
        });

        out.push({
            type: 'DEAMON-STATUS',
            contents: source,
        });

        out.push({
            type: 'ELAPSED-TIME',
            contents: source,
        });

        let tmp = [];
        tmp = tmp.concat(source.impures.map((impure) => {
            let out = {
                type: 'IMPURES',
                contents: impure,
                time: new Date(impure.created_at),
                purge: {
                    start: null,
                    end: null,
                    elapsed_time_total: null,
                }
            };

            let data = impure_purge_times[impure.id];
            if (data) {
                out.purge.end                = data.purge_end;
                out.purge.start              = data.purge_start;
                out.purge.elapsed_time_total = data.purge_elapsed_time_total;
            }

            return out;
        }));

        return []
            .concat(out)
            .concat(tmp);
    }
    /////
    ///// page-card_description
    /////
    pageCardDescriptionSize (request_gain, default_gain, base_size) {
        let gain = request_gain || default_gain;

        return (base_size * gain + base_size * (gain -1));
    }
}
