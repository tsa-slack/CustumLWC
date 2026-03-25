import { LightningElement, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import FORM_FACTOR from "@salesforce/client/formFactor";

export default class CustomerDetailNavButton extends NavigationMixin(
  LightningElement
) {
  @api recordId;

  get isMobile() {
    return FORM_FACTOR === "Small";
  }

  handleNavigate() {
    this[NavigationMixin.Navigate]({
      type: "standard__navItemPage",
      attributes: {
        apiName: "CustomerDetailPage"
      },
      state: {
        c__contactId: this.recordId
      }
    });
  }
}
