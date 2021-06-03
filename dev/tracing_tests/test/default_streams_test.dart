// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer' as developer;

import 'package:flutter_test/flutter_test.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

// This test ensures that the engine starts the VM with the timeline streams
// for "Dart", "Embedder", and "GC" recorded from startup.

void main() {
  late VmService vmService;

  setUpAll(() async {
    final developer.ServiceProtocolInfo info = await developer.Service.getInfo();

    if (info.serverUri == null) {
      fail('This test _must_ be run with --enable-vmservice.');
    }

    vmService = await vmServiceConnectUri(
      'ws://localhost:${info.serverUri!.port}${info.serverUri!.path}ws',
    );
  });

<<<<<<< HEAD
  tearDownAll(() {
    vmService.dispose();
=======
  tearDownAll(() async {
    await vmService.dispose();
>>>>>>> 02c026b03cd31dd3f867e5faeb7e104cce174c5f
  });

  test('Image cache tracing', () async {
    final TimelineFlags flags = await vmService.getVMTimelineFlags();
    expect(flags.recordedStreams, containsAll(<String>[
      'Dart',
      'Embedder',
      'GC',
    ]));
  }, skip: isBrowser); // uses dart:isolate and io
}
