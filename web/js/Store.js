class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    initPageHome () {
        return {
            code: "home", menu_label: '戦場',
            tag: 'page-home',
            children: [
                {
                    code: 'impures',
                    children: [
                        {
                            code: 'impure',
                            regex: new RegExp('^\\d+$'),
                            tag: 'impure_page',
                        }
                    ],
                },
                {
                    code: 'requests',
                    tag: 'request-messages',
                    children: [
                        {
                            code: 'impures',
                            children: [
                                {
                                    code: 'impure',
                                    regex: new RegExp('^\\d+$'),
                                    tag: 'impure_page',
                                }
                            ],
                        },
                    ],
                },
            ],
        };
    }
    childPageImpures () {
        return {
            code: 'impures',
            children: [
                {
                    code: 'impure',
                    regex: new RegExp('^\\d+$'),
                    tag: 'impure_page',
                }
            ],
        };
    }
    childPageDeamons () {
        return {
            code: "deamons",
            children: [
                {
                    code: "deamon",
                    regex: /^\d+$/,
                    tag: 'deamon-page',
                },
            ]
        };
    }
    pageOrthodoxs () {
        return {
            code: "orthodoxs",
            tag: 'orthodoxs-page',
            menu_label: '正教',
            children: [
                {
                    code: "orthodox",
                    regex: /^\d+$/,
                    tag: 'orthodox-page',
                },
                {
                    code: "exorcists",
                    children: [
                        {
                            code: "exorcist",
                            regex: /^\d+$/,
                            tag: 'exorcist-page',
                        },
                    ]
                },
            ]
        };
    }
    pageDeamons () {
        return {
            code: "deamons",
            tag: 'deamons-page',
            menu_label: '悪魔',
            children: [
                {
                    code: "deamon",
                    regex: /^\d+$/,
                    tag: 'deamon-page',
                },
            ]
        };
    }
    pagePurges () {
        return {
            code: "purges",
            tag: 'page-purges',
            menu_label: '浄歴',
            children: [
                this.childPageImpures(),
                this.childPageDeamons(),
            ],
        };
    }
    pageWarHistory () {
        return {
            code: "war-history",
            tag: 'war-history-page',
            menu_label: '戦歴',
            children: [
                {
                    code: "deamons",
                    children: [
                        {
                            code: "deamon",
                            regex: /^\d+$/,
                            tag: 'deamon-page',
                        },
                    ]
                }
            ],
        };
    }
    pageCemeteries () {
        return {
            code: "cemeteries",
            tag: 'cemetery_page',
            menu_label: '墓地',
            children: [
                this.childPageImpures(),
            ],
        };
    }
    pages() {
        return [
            this.initPageHome(),
            this.pagePurges(),
            this.pageCemeteries(),
            this.pageWarHistory(),
            this.pageDeamons(),
            this.pageOrthodoxs(),
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
            profiles:     { orthodox: null },
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
