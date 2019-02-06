class TimeStripper  {
    constructor(reducer) {}
    format (dt) {
        return dt ? moment(dt).format("YYYY-MM-DD HH:mm:ss") : '---';
    }
    format_sec (elapse) {
        let int2dstr = (i) => {
            return (i<10) ? '0' + i : i + '';
        };

        let sec = elapse % 60;

        let elapse_min = (elapse - sec) / 60;

        let min = elapse_min % 60;

        let elapse_hour = (elapse_min - min) / 60;

        let hour = elapse_hour % 24;

        let day = (elapse_hour - hour) / 24;

        let time_str = int2dstr(hour) + ':' + int2dstr(min) + ':' + int2dstr(sec);
        let day_str = (day>0) ? day + ' 日 ' : '';

        return day_str + time_str;
    }
    format_elapsedTime (start, end) {
        if (!start || !end) return '';

        let int2dstr = (i) => {
            return (i<10) ? '0' + i : i + '';
        };

        let elapse = moment(end).diff(moment(start)) / 1000;

        if (elapse<0) elapse = elapse * -1;

        return this.format_sec(elapse);
    };
    str2date (str) {
        let val = str;

        if (val===null || val=="") return null;

        let regex = /^\d+-\d+-\d+\s\d+:\d+:\d+$/;
        if (val.match(regex))
            new Error("Invalid datetime. val=" + str);

        let date = moment(val);
        if (!date.isValid())
            new Error("Invalid datetime. val=" + str);

        return date.toISOString();
    };
    is_date (str) {
        return this.str2date(str) ? true : false;
    };
}
