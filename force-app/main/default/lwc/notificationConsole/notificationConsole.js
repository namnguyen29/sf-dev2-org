import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

export default class NotificationConsole extends LightningElement {
  @track notifications = [];

  async connectedCallback() {
    onError((error) => {
      this.dispatchEvent(
        new ShowToastEvent({
          variant: 'error',
          title: 'EMP API Error',
          message: "Check your browser's developer console for more details.",
        }),
      );
      console.log('EMP API error reported by server: ', JSON.stringify(error));
    });

    this.subscription = await subscribe('/event/Notification__e', -1, (event) => {
      this.handleNotificationEvent(event);
    });

    this.dispatchEvent(
      new ShowToastEvent({
        variant: 'success',
        title: 'Ready to receive notifications',
      }),
    );
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
  }

  get notificationCount() {
    return this.notifications.length;
  }

  handleClearClick() {
    this.notifications = [];
  }

  handleNotificationEvent(event) {
    console.dir(event);
    const id = event.data.event.replayId;
    const message = event.data.payload.Message__c;
    const utcDate = new Date(event.data.payload.CreatedDate);
    const time = `${utcDate.getMinutes()}:${utcDate.getSeconds()}`;

    const notification = {
      id,
      message,
      time,
    };
    this.notifications.push(notification);
    this.dispatchEvent(
      new ShowToastEvent({
        variant: 'info',
        title: message,
      }),
    );
  }
}
