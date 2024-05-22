import { apiInitializer } from "discourse/lib/api";
import CustomCategoriesNavbar from "../components/custom-categories-navbar";

export default apiInitializer("1.13.0", (api) => {
  renderHeaderNav(api);
});

function renderHeaderNav(api) {
  api.renderInOutlet("after-header-panel", CustomCategoriesNavbar);
}