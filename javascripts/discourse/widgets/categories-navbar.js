import { hbs } from "ember-cli-htmlbars";
import RenderGlimmer from "discourse/widgets/render-glimmer";
import { createWidget } from "discourse/widgets/widget";

createWidget("custom-categories-navbar", {
  tagName: "div.custom-categories-navbar",
  html() {
    return [
      new RenderGlimmer(
        this,
        "div",
        hbs`
        <CustomCategoriesNavbar />
        `
      ),
    ];
  },
});
