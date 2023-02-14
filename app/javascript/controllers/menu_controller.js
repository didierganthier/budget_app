import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]  

  toggle() {
    console.log('it works')
 }  
}
