class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    initPageHome () {
        return {
            code: "home", menu_label: '戦場',
            tag: 'home_page',
            children: [
                {
                    code: 'impures',
                    children: [
                        {
                            code: 'impure',
                            regex: new RegExp('^\\d+$'),
                            tag: 'home_impure',
                            children: [],
                        }
                    ],
                },
            ],
        };
    }
    pages() {
        return [
            this.initPageHome(),
            {
                code: "purges",
                tag: 'purges_page',
                menu_label: '浄歴',
                children: [],
            },
            {
                code: "cemetery", menu_label: '墓地',
                tag: 'cemetery_page',
                children: [],
            },
            {
                code: "war-history", menu_label: '戦歴',
                tag: 'war-history_page',
                children: [],
            },
            {
                code: "deamons", menu_label: '悪魔',
                tag: 'deamons_page',
                children: [],
            },
            {
                code: "orthodox", menu_label: '正教',
                tag: 'orthodox_page',
                children: [],
            },
            {
                code: "help", menu_label: '聖書',
                tag: 'help_page',
                children: [],
            },
            {
                code: "angel", menu_label: '祓師',
                tag: 'angel_page',
                children: [],
            },
        ];
    }
    coreData() {
        return {
            orthodoxs:    { ht: {}, list: [] },
            maledicts:    { ht: {}, list: [] },
            deccots:      { ht: {}, list: [] },
            deamons:      { ht: {}, list: [] },
            impures:      { ht: {}, list: [] },
            impures_done: { ht: {}, list: [] },
            purges:       { ht: {}, list: [] },
            angels:       { ht: {}, list: [] },
            // これは個別にするほうが良いのだろうか。。。
            gitlab:       { ht: {}, list: [] },
        };
    }
    initRouteData () {
        return {
            active_page: 'home',
            home_page: 'home',
            randing_page: 'randing',
            pages: this.pages(),
        };
    }
    initSelectedData () {
        return {
            home: {
                maledict: null,
                service: null,
            },
        };
    }
    init () {
        let core_data = this.coreData();
        let site_data = {
            site: {
                active_page: 'home',
                home_page: 'home',
                randing_page: 'randing',
                pages: this.pages(),
            }
        };

        let data = Object.assign(
            {
                purging: {
                    impure: null,
                },
                messages: [],
                site: this.initRouteData(),
                selected: this.initSelectedData(),
            },
            core_data);

        for (var i in data.site.pages) {
            let page = data.site.pages[i];
            for (var k in page.sections) {
                let section = page.sections[k];
                let hash = '#' + page.code;

                if (section.code!='root')
                    hash += '/' + section.code;

                section.hash = hash;
            }
        }

        this._contents = Immutable.Map(data);
        return this;
    }
}
