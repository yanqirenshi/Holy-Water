class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    pages() {
        return [
            {
                code: "home", menu_label: '戦',
                active_section: 'root', home_section: 'root',
                sections: [
                    { code: 'root', tag: 'home_page_root' },
                ],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
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
                code: "angel", menu_label: '天使',
                active_section: 'root', home_section: 'root',
                sections: [{ code: 'root', tag: 'angel_page_root', title: 'Home', description: '' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
        ];
    }
    init () {
        let data = {
            maledicts: { ht: {}, list: [] },
            impures: { ht: {}, list: [] },
            purges: { ht: {}, list: [] },
            angels: { ht: {}, list: [] },
            site: {
                active_page: 'home',
                home_page: 'home',
                randing_page: 'randing',
                pages: this.pages(),
            },
            messages: [],
        };

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
