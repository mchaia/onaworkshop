<pre>
$ kubectl apply -f deployment.yml
deployment.apps/telegrambot created

$ kubectl get deployment telegrambot
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
telegrambot   1/1     1            1           90s

$ kubectl get pods --selector=app=telegrambot
NAME                          READY   STATUS    RESTARTS   AGE
telegrambot-8db54c788-bw8kr   1/1     Running   0          111s

$ kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" -l app=telegrambot
<b>nicopaez/telegrambot:0.0.7</b>
</pre>
