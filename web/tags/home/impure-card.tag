<impure-card>
    <div class="card" style="">
        <header class="card-header">
            <p class="card-header-title">
                Component
            </p>
            <a href="#" class="card-header-icon" aria-label="more options">
                <span class="icon">
                    <i class="fas fa-angle-down" aria-hidden="true"></i>
                </span>
            </a>
        </header>
        <div class="card-content">
            <div class="content">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.
                <a href="#">@bulmaio</a>. <a href="#">#css</a> <a href="#">#responsive</a>
                <br>
                <time datetime="2016-1-1">11:09 PM - 1 Jan 2016</time>
            </div>
        </div>
        <footer class="card-footer">
            <a href="#" class="card-footer-item">Save</a>
            <a href="#" class="card-footer-item">Edit</a>
            <a href="#" class="card-footer-item">Delete</a>
        </footer>
    </div>

    <style>
     impure-card > .card {
         width: 222px;
         height: calc(1.618 * 222px);
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;
     }
     impure-card > .card .card-content{
         height: calc(222px + 39px);
     }
    </style>
</impure-card>
