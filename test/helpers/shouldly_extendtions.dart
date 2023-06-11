// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:shouldly/shouldly.dart';

extension ColorShouldyExtension on Color {
  ColorAssertions get should => ColorAssertions(this);
}

class ColorAssertions extends BaseAssertions<Color, ColorAssertions> {
  ColorAssertions(
    super.subject, {
    super.isReversed,
    super.subjectLabel,
  });

  @override
  ColorAssertions be(Color expected) {
    subject.should.not.beNull();
    subject!.green.should.be(expected.green);
    subject!.blue.should.be(expected.blue);
    subject!.red.should.be(expected.red);
    subject!.alpha.should.be(expected.alpha);
    return this;
  }

  @override
  ColorAssertions copy(
    Color? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return ColorAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
