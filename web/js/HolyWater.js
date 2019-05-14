class HolyWater {
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
}
