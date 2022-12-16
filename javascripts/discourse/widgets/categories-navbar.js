import { createWidget } from "discourse/widgets/widget";
import RenderGlimmer from "discourse/widgets/render-glimmer";
import { hbs } from "ember-cli-htmlbars";

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
