/**
 *   自分用ルーター。
 *
 *   store (hash-table)
 *   ==================
 *   site: {
 *       pages: [
 *          {
 *             code: "home",
 *             test: '{regex} or {function}'
 *             sections: [ // ここは children に変更しよう。
 *                 {
 *                    code: 'root',
 *                    test: 'regex' or function
 *                    tag: 'home_page_root'
 *                    children: [...]
 *                 },
 *             ]
 *             active_section: 'root',  // これは自動で付与するようにしても良いのかもしれない
 *             home_section: 'root',    //   〃
 *          }
 *       ]
 *       active_page: 'home', // これは自動で付与するようにしても良いのかもしれない
 *       home_page: 'home',   //   〃
 *   }
 *
 */
class Router {
    constructor(store, actions) {
        this._store = store;
        this._actions = actions;

        let self = this;
        route(function (a) {
            self.routing(Array.prototype.slice.call(arguments));
        });
    }
    start () {
        route.start(function () {
            let hash = location.hash;
            let len = hash.length;

            if (len==0)
                return '/';

            return hash.substring(1);
        }());
    }
    /* **************************************************************** *
     *  Routing
     *  =======
     *
     * **************************************************************** */
    findSite (site, args) {

        if (!args || args.length==0)
            return null;

        let arg = args[0];

        let page = site.find((d) => {
            if (d.regex)
                return d.regex.exec(arg);
            else
                return d.code == arg;
        });

        if (!page)
            return null;

        if (args.length==1)
            return page;

        // そんなに深くならないと思うので。。。。再帰で。。。
        return this.findSite(page.sections, args.splice(1));
    }
    /**
     * ???
     * @param {hash-table}  site サイト(ページ)の全データ
     * @param {array} args ハッシュを '/' で split した配列
     */
    getPageCode (site, args) {
        let len = args.length;

        if (!args[0])
            return site.randing_page;

        let x = this.findSite(site.pages, args);

        return x ? x : null;
    }
    /**
     * ???
     * @param {hash-table}  site サイト(ページ)の全データ
     * @param {string}      page_code 取得したいページのコード
     */
    getPage (site, page_code) {
        return site.pages.find((d) => {
            return d.code == page_code;
        });
    }
    /**
     * これ、何しているんだったっけ？
     * @param {hash-table}  page サイトのデータ
     * @param {array}       args ハッシュを '/' で split した配列
     */
    getActiveSection (page, args) {
        // TODO: ここを階層でもイケるようにする。
        //   args で page の階層を検索し、ヒットしたものを返す。
        //   ヒットしない場合はエラーにする。
        return args.length>=2 ? args[1] : page.home_section;
    }
    /**
     * this is constructor description.
     * @param {array} args ハッシュを '/' で split した配列
     */
    routing (args) {
        let site = this._store.state().get('site');
        let actions = this._actions;

        let page = this.getPageCode(site, args);

        site.active_page = page.code;
        page.active_section = this.getActiveSection(page, args);

        actions.movePage({
            site: site
        });
    }
    /* **************************************************************** *
     *  Page
     *  =======
     *    site の階層再上位のものを page とします。
     *    その page を切り換える処理です。
     * **************************************************************** */
    isfindPageTag (tag) {
        let cls = tag.opts.class;

        return cls && cls.split(' ').find((c)=>{
            return c=='page';
        });
    }
    findPageTags (tags) {
        let page_tags = {};

        for (var k in tags) {
            let tag = tags[k];
            if (this.isfindPageTag(tag))
                page_tags[k] = tag;
        }

        return page_tags;
    }
    switchPage (root_tag, page_holder_elem, site) {
        let tags = root_tag.tags;
        let trg_show = [];

        for (let page of site.pages) {
            let key = page.code;
            let tag = tags[key];

            if (site.active_page==key) {
                if (!tag) {
                    trg_show.push(key);
                }
                if (tag && !tag.isMounted) {
                    trg_show.push(key);
                }
                if (tag && tag.isMounted) {
                    tag.update();
                }
            } else {
                if (tag && tag.isMounted)
                    tag.unmount();
            }
        }

        for (var i in trg_show) {
            let tag_name = trg_show[i];

            var elem = document.createElement(tag_name);

            elem.classList.add('page');

            page_holder_elem.appendChild(elem);

            let new_page_tag = riot.mount(tag_name);
            root_tag.tags[tag_name] = new_page_tag[0];
        }
    }
    /* **************************************************************** *
     *  Section
     *  =======
     *    page の配下(children) のノードを section とします。
     *    その section を切り替える処理です。
     * **************************************************************** */
    mountSections (page, active_section_code, sections) {
        let root = page.root;

        for (var i in sections) {
            let section = sections[i];
            let tag_name = 'func-' + section.code;

            var elem = document.createElement(tag_name);

            if (section.code==active_section_code)
                elem.classList.add('page-section');
            else
                elem.classList.add('page-section', 'hide');

            root.appendChild(elem);

            let opts = {};
            if (section.code=='root')
                opts.sections = sections;

            let new_tags = riot.mount(tag_name, opts);

            page.tags[tag_name] = new_tags[0];
        }
    }
    switchSection (root_tag, active_section_code, sections_data) {
        let tags = root_tag.tags;
        let trg_show = [];

        for (var i in sections_data) {
            let section = sections_data[i];
            let section_code = section.code;
            let tag = tags[section.tag];

            if (active_section_code==section_code) {
                if (!tag) {
                    trg_show.push(section_code);
                }
                if (tag && !tag.isMounted) {
                    trg_show.push(section_code);
                }
                if (tag && tag.isMounted) {
                    tag.update();
                }
            } else {
                if (tag && tag.isMounted)
                    tag.unmount();
            }
        }

        for (var i in trg_show) {
            let tag_code = trg_show[i];
            let section_data = sections_data.find((d) => { return d.code==tag_code; });
            let tag_name = section_data.tag;

            var elem = document.createElement(tag_name);

            elem.classList.add('page-section');

            root_tag.root.appendChild(elem);

            let new_page_tag = riot.mount(tag_name, { page_code: root_tag.pageCode() });
            root_tag.tags[tag_name] = new_page_tag[0];
        }
    };
    /* **************************************************************** *
     *  Util
     *  =======
     *
     * **************************************************************** */
    isHaveClass (class_trg, class_string) {
        if (!class_string) return false;

        let classes = class_string.trim().split(' ');
        let results = classes.find((cls) => { return cls==class_trg; });

        return !(results.length==0);
    };
    rmClass (class_trg, class_string) {
        let classes = class_string.trim().split(' ');
        let results = classes.filter((cls) => { return cls!=class_trg; });

        return results.join(' ');
    };
    addClass (class_trg, class_string) {
        let classes = class_string.trim().split(' ');
        if (classes.filter((cls) => { return cls==class_trg; }).length==0)
            classes.push(class_trg);

        return classes.join(' ');
    };
}
