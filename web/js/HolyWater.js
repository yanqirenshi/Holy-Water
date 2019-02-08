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
    makeGunntChartData () {
        return {
            _class: 'WBS',
            _id: 1,
            code: '1',
            name: 'www.yahoo.co.jp',
            uri: 'https://www.yahoo.co.jp/',
            schedule: {
                start: moment().add(-1, 'day').toDate(),
                end: moment().add(1, 'day').toDate(),
            },
            children: [],
        };
    }
}
