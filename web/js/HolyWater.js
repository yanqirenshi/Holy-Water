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
            type: 'IMPURE-STATUS',
            contents: source,
        });

        out.push({
            type: 'IMPURE-STATUS-PURGE',
            contents: source,
        });

        out.push({
            type: 'IMPURE-DEAMON',
            contents: source,
        });

        out.push({
            type: 'IMPURE-ANGEL',
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

        return []
            .concat(out)
            .concat(tmp.sort((a, b) => {
                return a.time > b.time ? -1 : 1;
            }));
    }
}
