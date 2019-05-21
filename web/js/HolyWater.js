class HolyWater {
    constructor () {
        this.ts = new TimeStripper();
    }
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
}
