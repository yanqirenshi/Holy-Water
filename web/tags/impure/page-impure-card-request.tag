<page-impure-card-request>

    <d>
        <p>{time()}</p>
    </d>

    <d>
        <p><b>浄化依頼</b></p>
        <p>元: {angelNamefrom()}</p>
        <p>先: {angelNameTo()}</p>
        <p>{message()}</p>
    </d>

    <script>
     this.time = () => {
         return moment(this.opts.source.messaged_at).format('YYYY-MM-DD HH:mm (ddd)');
     }
     this.angelNameFrom = () => {
         return this.opts.source.angel_from_name;
     };
     this.angelNameTo = () => {
         return this.opts.source.angel_to_name;
     };
     this.message = () => {
         return this.opts.source.contents;
     };
    </script>

    <style>
     page-impure-card-request {
         display: block;
         width:  calc(88px * 1 + 11px * 0);
         height: calc(88px * 1 + 11px * 0);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }
    </style>
</page-impure-card-request>
