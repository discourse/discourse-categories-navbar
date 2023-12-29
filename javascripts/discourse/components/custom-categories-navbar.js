import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";

export default class CustomCategoriesNavbar extends Component {
  @service site;
  @service router;
  @tracked activeSlug = "";

  constructor() {
    super(...arguments);
    this.setActiveSlug();
    this.router.on("routeDidChange", this, this.setActiveSlug);
  }

  get shouldRender() {
    return !this.router.currentRouteName.startsWith("chat");
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
}
