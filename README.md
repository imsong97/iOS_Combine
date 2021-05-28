# iOS_Combine
https://developer.apple.com/documentation/combine
<h3>Combine</h3>
<p>이벤트 처리 연산자들을 통해 비동기 이벤트들을 핸들링 할 수 있게 하는 것</p>
<img src="https://user-images.githubusercontent.com/56987664/119977314-3b6eb000-bff3-11eb-89f0-872f087c61cb.png" width="80%">
<br>
<img src="https://user-images.githubusercontent.com/56987664/119977670-b0da8080-bff3-11eb-98d3-0e535faff9b7.png" width="50%">
<br>
<p>
<li>Publisher: 프로토콜 / AnyPublisher: Publisher을 따르는 struct</li>
<li>Subscriber: 프로토콜 / AnySubscriber: Subscriber를 따르는 struct
<li>Subscriber: 프로토콜 / AnySubscriber: Subscriber를 따르는 struct
</p>
<br>

<h3>Rx vs Combine</h3>
<img src="https://user-images.githubusercontent.com/56987664/119978041-1a5a8f00-bff4-11eb-828a-c706f23c6a97.png" width="80%">
<li>(Rx) Observable == (Combine) Publisher ||  AnyPublisher</li>
<li>(Rx) Observer == (Combine) Subscriber ||  AnySubscriber</li>
<li>Publisher는 만들 때 데이터 타입 뿐만 아니라 에러 타입까지 지정해주어야 함</li>
<pre>
<code>
Observable< String ><br>
AnyPublisher< String, Error > || AnyPublisher< String, Never >
</code>
</pre>