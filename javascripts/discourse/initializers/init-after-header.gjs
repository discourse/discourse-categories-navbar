import { apiInitializer } from "discourse/lib/api";
import CustomCategoriesNavbar from "../components/custom-categories-navbar";

export default apiInitializer((api) => {
  api.renderInOutlet("after-header", CustomCategoriesNavbar);
});
