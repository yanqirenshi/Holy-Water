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
                        }
                    ],
                },
                {
                    code: 'requests',
                    tag: 'request-messages',
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
            },
            {
                code: "cemetery",
                tag: 'cemetery_page',
                menu_label: '墓地',
            },
            {
                code: "war-history",
                tag: 'war-history_page',
                menu_label: '戦歴',
            },
            {
                code: "deamons",
                tag: 'deamons_page',
                menu_label: '悪魔',
            },
            {
                code: "orthodox",
                tag: 'orthodox_page',
                menu_label: '正教',
            },
            {
                code: "help",
                tag: 'help_page',
                menu_label: '聖書',
            },
            {
                code: "angel",
                tag: 'angel_page',
                menu_label: '祓師',
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
            request: {
                messages: {
                    unread: { ht: {}, list: [] },
                    readed: { ht: {}, list: [] },
                }
            },
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
