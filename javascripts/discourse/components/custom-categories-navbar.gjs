import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";
import { eq } from "truth-helpers";
import HorizontalOverflowNav from "discourse/components/horizontal-overflow-nav";
import categoryLink from "discourse/helpers/category-link";
import { getOwnerWithFallback } from "discourse-common/lib/get-owner";

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

  setActiveSlug() {
    const currentRoute = this.router.currentRoute;

    if (currentRoute && currentRoute.attributes?.category) {
      let activeCategory = currentRoute.attributes.category;

      while (activeCategory.parentCategory) {
        activeCategory = activeCategory.parentCategory;
      }

      this.activeSlug = activeCategory.slug;

      // scroll active category into view
      document
        .querySelector(`a[href*="/c/${this.activeSlug}"]`)
        .scrollIntoView({
          block: "nearest",
          inline: "center",
        });
    }
  }

  <template>
    <div class="custom-categories-navbar">
      <div>
        <HorizontalOverflowNav>
          {{#each this.site.categories as |sc|}}
            {{#unless sc.parentCategory}}
              <li>
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
