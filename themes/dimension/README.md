# Dimension

Dimension is a single page and responsive site template. It is a port of [HTML5 UP's Dimension theme](https://html5up.net/uploads/demos/dimension/).

![Dimension Theme screenshot](https://raw.githubusercontent.com/sethmacleod/dimension/master/images/screenshot.png)

## Installation

Run the following commands inside your Hugo site folder:

    $ git clone https://github.com/sethmacleod/dimension.git themes/dimension

Alternatively use git submodules in order to have a way to easily update the theme from the source in case you have your site in git as well.
For this run the following commands inside your Hugo site folder:

    $ git submodule add https://github.com/sethmacleod/dimension.git themes/dimension

If you checkout your site from a repository which has this added as a submodule (e.g. if you are using CI to deploy), execute following commands or put them into a initgit.sh file in your repository which can be executed by your CI:

    $ git submodule init
    $ git submodule update

In order to update all the existing submodules from their upstreams, you can either go into each submodule root folder and do the normal git pull or execute following command:

    $ git submodule foreach git pull

## Getting Started

After installation, you will need to configure the config.toml file, change pictures, and write your pages.

### The config file

Copy the `config.toml` from the exampleSite folder into your Hugo site's root folder. Change the fields as needed. Add or delete social media by following the examples in the file. You may need to look up the [font-awesome](http://fontawesome.io/) icon names. The icon field should be filled out without the "fa" prefix. The icon field for Twitter should be 'twitter' instead of 'fa-twitter'.

You can change the logo as well with font-awesome icons. The default is set to `fa-diamond`.
To use an image as logo, remove the `logo = "fa-diamond"` line and replace it with `logoimage = "/path/to/image.png"` and place your image at that location in the `static` folder. The image should be in square format and at least 86*86 pixels for best viewing experience.

### Changing pictures

Create an `images` folder in the static folder of your site -- **not** the theme's static folder. Add pictures to `/static/images` as needed. If you want to change the background image, the replacement image should be named `bg.jpg`.

### Writing your pages

To create a new page, run the following command inside your Hugo sites:

    $ hugo new your-page.md

Change `your-page` to what you want to name the file. There are three variables that you can change: `title`, `weight`, and `draft`. Weight is set to 0 by default, so be sure to change it.

As default, the title of the page will be taken as menu item. In case you have longer page titles, the menu may get distorted and you can set an additional parameter in the pages front matter to have a shorter menu name.
Just set `menuname = "<Your Short Name>"` in that page and it will use this optional parameter. 

You can also copy the pages from the exampleSite folder and modify those pages.

### Contact Form

You will need to use an external service for the contact form since static sites cannot handle forms on their own. One such service is [Formspree](https://formspree.io/). Formspree has a free tier. Check out the `formspree.md` page in the exampleSite folder for a template.

### Tabs as Links

You may want a tab to link to external content. Create your page, and set a variable `link` in the front matter to your desired output. For example: `link = "http://www.example.org"`. Note: this method could be used to link to internal pages, but the theme does not support this out of the box.

## Multilingual Support

For the `config.toml`, follow the template at the bottom of `config.toml` in your exampleSite folder. German is used as the example language, but you can use any language you want. For content files, it is suggested to use the same base file name for each translate page. For example, for `about.md`, use `about.de.md` for the German page. 

## Google Analytics
To include Google Analytics, you can follow the standard Hugo way and just add `googleAnalytics = "UA-123-45"` to the `config.toml` as described on [Analytics in Hugo](https://gohugo.io/extras/analytics/). 

## CSS Overrides
If you need to override some CSS properties or add new ones which will be on top of the existing template CSS, you can create the file `static/css/project.css` and it will be loaded after the themes own CSS files.

Changing the background color for the content modals would need the following addition to the `project.css`

    #main article {
			background-color: rgba(89, 64, 50, 0.85);
		} 

## License

This theme is released under the CC BY 3.0 license. For more information, read the [License](https://github.com/sethmacleod/dimension/blob/master/LICENSE.md).
