<home_other-services>
    <nav class="panel hw-box-shadow">
        <p class="panel-heading">Services</p>

        <a each={data()}
           class="panel-block"
           angel-id={id}
           deccot-id={id}
           service={service}
           onclick={click}
           style="font-size:11px;">

            <span style="width:100%;"
                  deccot-id={id}
                  service={service}>
                {service}
            </span>

            <span class="operators">
            </span>
        </a>
    </nav>

    <script>
     this.dragging = false;
     this.active_maledict = null;
    </script>

    <script>
     this.data = () => {
         return STORE.get('deccots').list;
     };
    </script>

    <script>
     this.click = (e) => {
         let elem = e.target;

         ACTIONS.selectServiceItem({
             service: elem.getAttribute('service'),
             id: elem.getAttribute('deccot-id'),
         })
         /* ACTIONS.fetchServiceItems(
          *     elem.getAttribute('service'),
          *     elem.getAttribute('deccot-id')) */
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
    </script>

    <style>
     home_other-services > .panel {
         width: 188px;
         margin-top: 22px;
         border-radius: 4px 4px 0 0;
     }
     home_other-services > .panel > a {
         background: #ffffff;
     }
     home_other-services > .panel > .panel-heading {
         font-size:12px;
         font-weight: bold;
     }
     home_other-services .move-door.close .opened-door{
         display: none;
     }
     home_other-services .move-door.open .closed-door{
         display: none;
     }
    </style>
</home_other-services>
