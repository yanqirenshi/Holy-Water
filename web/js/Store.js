class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    initPageHome () {
        return {
            code: "home", menu_label: '戦場',
            active_section: 'root',
            home_section: 'root',
            sections: [
                { code: 'root', tag: 'home_page_root' },
                {
                    code: 'impures',
                    sections: [
                        {
                            code: 'impure',
                            regex: new RegExp('^\\d+$'),
                            tag: 'home_impure',
                            home_section: 'root',
                            sections: [
                                { code: 'root', tag: 'home_page_root' },
                            ],
                        }
                    ],
                },
            ],
            stye: {
                color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
            }
        };
    }
    pages() {
        return [
            this.initPageHome(),
            {
                code: "purges",
                menu_label: '浄歴',
                active_section: 'root',
                home_section: 'root',
                sections: [
                    { code: 'root', tag: 'purges_page_root', name: 'root' },
                ],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "cemetery", menu_label: '墓地',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'cemetery_page_root' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "war-history", menu_label: '戦歴',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'war-history_page_root' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "deamons", menu_label: '悪魔',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'deamons_page_root' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "orthodox", menu_label: '正教',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'orthodox_page_root', title: 'Home', description: '' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "help", menu_label: '聖書',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'help_page_root', title: 'Home', description: '' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "angel", menu_label: '祓師',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'angel_page_root', title: 'Home', description: '' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
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
