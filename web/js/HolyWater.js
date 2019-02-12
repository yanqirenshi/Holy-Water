class HolyWater {
    summaryPurges (purges) {
        return purges.reduce((a,b) => {
            return a + moment(b.end).diff(b.start, 'second');
        }, 0.0);
    }
    getDeamonInImpureName (impure_name) {
        let pos = impure_name.indexOf('：');
        return (pos==-1) ? 'other' : impure_name.substring(0,pos);
    }
    summaryPurgesAtDeamons (purges) {
        let ht = {};

        ht.other = { name: 'other', time: 0.0, list: [] };

        for (let purge of purges) {
            let sec = moment(purge.end).diff(moment(purge.start), 'second');

            let key = this.getDeamonInImpureName(purge.impure_name);

            if (!ht[key]) ht[key] = { name: key, time: 0.0, list: [] };

            ht[key].list.push(purge);
            ht[key].time += sec;
        }

        let out = [];
        for (let k in ht)
            out.push(ht[k]);

        return out;
    }
    makeGunntChartData (core) {
        return {
            _class: 'WORKPACKAGE',
            _id: core._id,
            code: core.impure_id,
            name: core.impure_name,
            uri: '',
            schedule: {
                start: core.start,
                end: core.end,
            },
            children: [],
            _core: core,
        };
    }
}
