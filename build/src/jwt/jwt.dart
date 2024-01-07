// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class Jwt {
  String signJwt({required Map<String, dynamic> payload});
  bool verifyJwt(String jwtToken);
}
