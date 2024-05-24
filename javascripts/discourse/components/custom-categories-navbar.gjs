import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { getOwner } from "@ember/owner";
import { service } from "@ember/service";
import { eq } from "truth-helpers";
import HorizontalOverflowNav from "discourse/components/horizontal-overflow-nav";
import categoryLink from "discourse/helpers/category-link";

export default class CustomCategoriesNavbar extends Component {
  static shouldRender(args, context) {
    const router = getOwner(context).lookup("service:router");

    if (router.currentRouteName.startsWith("chat")) {
      return false;
    }

    const header = getOwner(context).lookup("service:header");

    return context.site.desktopView || !header.topic;
  }

  @service site;
  @service router;

  @tracked activeSlug = "";

  constructor() {
    super(...arguments);
    this.setActiveSlug();
    this.router.on("routeDidChange", this, this.setActiveSlug);
  }

  willDestroy() {
    super.willDestroy(...arguments);
    this.router.off("routeDidChange", this, this.setActiveSlug);
  }

  setActiveSlug() {
    let activeCategory =
      this.router.currentRoute?.attributes?.category ||
      this.router.currentRoute?.parent?.attributes?.category;

    if (activeCategory) {
      while (activeCategory.parentCategory) {
        activeCategory = activeCategory.parentCategory;
      }

      this.activeSlug = activeCategory.slug;
    } else {
      this.activeSlug = "";
    }

    const targetSelector = this.activeSlug
      ? `.custom-categories-navbar li[data-slug="${this.activeSlug}"]`
      : `.custom-categories-navbar li:first-child`;

    // adding a small timeout to allow the browser to render all elements, otherwise scrollIntoView's
    // behavior is inconsistent, only working sometimes
    setTimeout(() => {
      // scroll active category into view
      document.querySelector(targetSelector)?.scrollIntoView({
        block: "nearest",
        inline: "center",
      });
    }, 50);
  }

  <template>
    <div class="custom-categories-navbar">
      <div>
        <HorizontalOverflowNav>
          {{#each this.site.categories as |sc|}}
            {{#unless sc.parentCategory}}
              <li data-slug={{sc.slug}}>
                {{categoryLink
                  sc
                  extraClasses=(if (eq this.activeSlug sc.slug) "active")
                }}
              </li>
            {{/unless}}
          {{/each}}
        </HorizontalOverflowNav>
      </div>
    </div>
  </template>
}
