import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";

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
    const isChat = this.router.currentRouteName.startsWith("chat");
    const isMinimized = this.args.outletArgs.minimized;
    const alwaysHideDocked = settings.hide_on_topic_scroll
      ? isMinimized
      : this.site.mobileView && isMinimized;

    return !(alwaysHideDocked && !isChat) && !isChat;
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
        ?.scrollIntoView({
          block: "nearest",
          inline: "center",
        });
    }
  }
}
