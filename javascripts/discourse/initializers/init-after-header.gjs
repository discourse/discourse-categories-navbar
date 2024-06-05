import { apiInitializer } from "discourse/lib/api";
import CustomCategoriesNavbar from "../components/custom-categories-navbar";

export default apiInitializer("1.15.0", (api) => {
  api.renderInOutlet("after-header", CustomCategoriesNavbar);
});
