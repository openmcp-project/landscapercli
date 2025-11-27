// SPDX-FileCopyrightText: 2025 SAP SE or an SAP affiliate company and openmcp-project contributors
//
// SPDX-License-Identifier: Apache-2.0

package cmd

import (
	"context"
	"fmt"
	"os"

	"github.com/spf13/cobra"

	"github.com/openmcp-project/landscapercli/cmd/blueprints"
	"github.com/openmcp-project/landscapercli/cmd/completion"
	"github.com/openmcp-project/landscapercli/cmd/installations"
	"github.com/openmcp-project/landscapercli/cmd/quickstart"
	"github.com/openmcp-project/landscapercli/cmd/targets"
	"github.com/openmcp-project/landscapercli/cmd/version"
	"github.com/openmcp-project/landscapercli/pkg/logger"
)

func NewLandscaperCliCommand(ctx context.Context) *cobra.Command {
	cmd := &cobra.Command{
		Use:   "landscaper-cli",
		Short: "landscaper cli",
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			log, err := logger.NewCliLogger()
			if err != nil {
				fmt.Println("unable to setup logger")
				fmt.Println(err.Error())
				os.Exit(1)
			}
			logger.SetLogger(log)
		},
	}

	logger.InitFlags(cmd.PersistentFlags())

	cmd.AddCommand(version.NewVersionCommand())
	cmd.AddCommand(blueprints.NewBlueprintsCommand(ctx))
	cmd.AddCommand(quickstart.NewQuickstartCommand(ctx))
	cmd.AddCommand(installations.NewInstallationsCommand(ctx))
	cmd.AddCommand(targets.NewTargetsCommand(ctx))
	cmd.AddCommand(completion.NewCompletionCommand())

	return cmd
}
