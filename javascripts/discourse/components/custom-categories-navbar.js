import Component from "@glimmer/component";
import { inject as service } from "@ember/service";

export default class CustomCategoriesNavbar extends Component {
  @service site;
  @service router;

  get currentCategory() {
    const currentRoute = this.router.currentRoute;
    if (currentRoute && currentRoute.attributes) {
      return currentRoute.attributes.category;
    }
  }
}
