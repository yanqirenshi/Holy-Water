<page-impure-card>
    <page-impure-card-status      if={opts.source.type=="IMPURE-STATUS"}      source={opts.source.contents}></page-impure-card-status>
    <page-impure-card-angel       if={opts.source.type=="IMPURE-ANGEL"}       source={opts.source.contents}></page-impure-card-angel>
    <page-impure-card-deamon      if={opts.source.type=="IMPURE-DEAMON"}      source={opts.source.contents}></page-impure-card-deamon>
    <page-impure-card-description if={opts.source.type=="IMPURE-DESCRIPTION"} source={opts.source.contents}></page-impure-card-description>
    <page-impure-card-incantation if={opts.source.type=="IMPURE-SPELL"}       source={opts.source.contents}></page-impure-card-incantation>
    <page-impure-card-purge       if={opts.source.type=="IMPURE-PURGE"}       source={opts.source.contents}></page-impure-card-purge>
    <page-impure-card-request     if={opts.source.type=="IMPURE-REQUEST"}     source={opts.source.contents}></page-impure-card-request>

    <style>
     page-impure-card {
         display: block;
         margin-bottom: 11px;
     }
    </style>

</page-impure-card>
